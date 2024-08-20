import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/post_widget.dart';
import 'package:provider/provider.dart';

import '../database/database_provider.dart';
import '../helper/navigate_widget.dart';
import '../models/post.dart';

class ContentBest extends StatefulWidget {
  const ContentBest({super.key});

  @override
  State<ContentBest> createState() => _ContentBestState();
}

class _ContentBestState extends State<ContentBest> {
  final String _currentZone = 'C - 137';

  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // fetch local posts on init
  @override
  void initState() {
    super.initState();

    loadBestPosts();
  }

  Future<void> loadBestPosts() async {
    await databaseProvider.loadBestPosts(_currentZone);
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
      body: _buildBestList(listeningProvider.bestPosts),
    );
  }

  Widget _buildBestList(List<Post> posts) {
    return posts.isEmpty
        ? const Center(child: Text('No one in the world has posted yet.'))
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
