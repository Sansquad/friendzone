import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friendzone/models/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: widget.post.profileImgUrl.isNotEmpty
                      ? NetworkImage(widget.post.profileImgUrl)
                      : null,
                  child: widget.post.profileImgUrl.isEmpty
                      ? Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.username,
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.inverseSurface,
                        //fontSize: 12,
                      ),
                    ),
                    Text(
                      timeago.format(
                          (widget.post.timestamp).toDate()),
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context)
                            .colorScheme
                            .inverseSurface
                            .withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/post_bookmark.svg',
                  height: 14,
                  width: 14,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.post.contentText,
              style: TextStyle(
                fontFamily: 'ABeeZee',
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 13,
              ),
            ),
            if (widget.post.contentImageUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.network(widget.post.contentImageUrl),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/post_like.svg',
                      height: 14,
                      width: 14,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    const SizedBox(width: 4),
                    Text(widget.post.likeCount.toString()),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/icons/post_comment.svg',
                      height: 14,
                      width: 14,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    const SizedBox(width: 4),
                    Text(widget.post.commentCount.toString()),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/bar_home.svg',
                  height: 15,
                  width: 15,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.post.gridCode,
                  style: TextStyle(
                    fontFamily: 'BigShouldersDisplay',
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context)
                        .colorScheme
                        .inverseSurface
                        .withOpacity(0.5),
                    //fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
