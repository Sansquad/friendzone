import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/post_widget.dart';
import 'package:friendzone/database/database_provider.dart';
import 'package:friendzone/helper/navigate_widget.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';

class ContentHome extends StatefulWidget {
  const ContentHome({super.key});

  @override
  State<ContentHome> createState() => _ContentHomeState();
}

class _ContentHomeState extends State<ContentHome> {
  final String _currentZone = 'C - 137';

  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // fetch local posts on init
  @override
  void initState() {
    super.initState();

    loadLocalPosts();
  }

  Future<void> loadLocalPosts() async {
    await databaseProvider.loadLocalPosts(_currentZone);
  }

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
                'assets/icons/bar_home.svg',
                height: 27,
                width: 27,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Zone $_currentZone',
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
            onPressed: () {
              print("Pressed notification icon");
            },
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
            onPressed: () {
              // 승제 쿤 adding google map stuff 20240817
              Navigator.pushNamed(context, '/testmap');

              Navigator.pushNamed(context, '/contentmap');
            },
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
      body: _buildLocalList(listeningProvider.localPosts),
    );
  }

  Widget _buildLocalList(List<Post> posts) {
    return posts.isEmpty
        ? const Center(child: Text('No posts in the current zone yet.'))
        : ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              color:
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.4),
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostWidget(
                post: post,
                onUserTap: () => goUserPage(context, post.uid),
                onPostTap: () => goPostPage(context, post),
              );
            },
          );
  }
}
