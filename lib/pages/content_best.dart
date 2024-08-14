import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/post_widget.dart';

class ContentBest extends StatefulWidget {
  const ContentBest({super.key});

  @override
  State<ContentBest> createState() => _ContentBestState();
}

class _ContentBestState extends State<ContentBest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bar_best.svg',
                height: 27,
                width: 27,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Best of Zones',
                style: TextStyle(
                  fontFamily: 'BigShouldersText',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            highlightColor: Colors.transparent,
            visualDensity: VisualDensity.compact,
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/bar_notification.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.inverseSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
          IconButton(
            highlightColor: Colors.transparent,
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SvgPicture.asset(
                'assets/icons/bar_map.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.inverseSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bestPosts')
            .orderBy('likeCount', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No posts globally!'));
          }

          final bestPosts = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final user = data['user'] as Map<String, dynamic>?;
            return {
              'gridCode': data['gridCode'] ?? 'Unknown',
              'username': user?['username'] ?? 'Unknown',
              'profileImgUrl': user?['profileImgUrl'] ?? '',
              'timestamp': data['timestamp'] ?? 'Unknown',
              'contentText': data['contentText'] ?? '',
              'likeCount': data['likeCount'] ?? 0,
              'commentCount': data['commentCount'] ?? 0,
              'contentImageUrl': data['contentImageUrl'] ?? ''
            };
          }).toList();

          return ListView.builder(
            itemCount: bestPosts.length,
            itemBuilder: (context, index) {
              final post = bestPosts[index];
              return Column(
                children: [
                  PostWidget(postData: post),
                  Divider(
                    color: Color(0xff999999),
                    height: 0,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
