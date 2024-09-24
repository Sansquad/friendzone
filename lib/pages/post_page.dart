import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/post_widget.dart';
import 'package:friendzone/helper/navigate_widget.dart';
import 'package:friendzone/models/post.dart';

class PostPage extends StatefulWidget {
  final Post post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
            highlightColor: Colors.transparent,
            icon: SvgPicture.asset(
              'assets/icons/bar_back.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          '${widget.post.username}\'s Post',
          style: const TextStyle(
            fontFamily: 'BigShouldersText',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        children: [
          PostWidget(
            post: widget.post,
            onUserTap: () => goUserPage(context, widget.post.uid),
            onPostTap: () {},
          ),
          Divider(
            color:
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.4),
            height: 0,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          )
          //TODO add comments
        ],
      ),
    );
  }
}
