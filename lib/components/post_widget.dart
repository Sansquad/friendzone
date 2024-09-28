import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friendzone/database/database_provider.dart';
import 'package:friendzone/models/post.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;

  const PostWidget({
    super.key,
    required this.post,
    required this.onUserTap,
    required this.onPostTap,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  // TODO gotta add logic (add saved posts field for user?)
  bool saved = false;

  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  void _toggleLikePost() async {
    try {
      await databaseProvider.toggleLike(widget.post.id);
    } catch (e) {
      print(e);
    }
  }

  void _showOptions() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text("Edit"),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO handle edit
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Delete"),
                  onTap: () async {
                    Navigator.pop(context);
                    await databaseProvider.deletePost(
                        databaseProvider.currentZone, widget.post.id);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Cancel"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _savePost() {
    saved = !saved;
  }

  @override
  Widget build(BuildContext context) {
    String currentUid = FirebaseAuthService().getCurrentUid();
    final bool isPostOwner = widget.post.uid == currentUid;
    bool likeByUser = listeningProvider.isLikedByUser(widget.post.id);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: GestureDetector(
        onTap: widget.onPostTap,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.onUserTap,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: widget.post.profileImgUrl.isNotEmpty
                          ? NetworkImage(widget.post.profileImgUrl)
                          : null,
                      backgroundColor: widget.post.profileImgUrl.isEmpty
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      child: widget.post.profileImgUrl.isEmpty
                          ? SvgPicture.asset(
                              'assets/icons/default_avatar.svg',
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.surface,
                                BlendMode.srcIn,
                              ),
                              width: 21,
                              height: 21,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: widget.onUserTap,
                        child: Text(
                          widget.post.username,
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.inverseSurface,
                            //fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        timeago.format((widget.post.timestamp).toDate()),
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
                  GestureDetector(
                    onTap: () {
                      if (isPostOwner) {
                        _showOptions();
                      } else {
                        _savePost();
                      }
                    },
                    child: isPostOwner
                        ? Icon(Icons.more_horiz)
                        : SvgPicture.asset(
                            'assets/icons/post_bookmark.svg',
                            height: 14,
                            width: 14,
                            color: saved
                                ? Colors.red
                                : Theme.of(context)
                                    .colorScheme
                                    .inverseSurface, // TODO replace all color (deprecated)
                          ),
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
                      GestureDetector(
                        onTap: _toggleLikePost,
                        child: SvgPicture.asset(
                          'assets/icons/post_like.svg',
                          height: 14,
                          width: 14,
                          color: likeByUser
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.inverseSurface,
                        ),
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
                  GestureDetector(
                    //onTap: Placeholder(),
                    child: SvgPicture.asset(
                      'assets/icons/bar_home.svg',
                      height: 15,
                      width: 15,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
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
      ),
    );
  }
}
