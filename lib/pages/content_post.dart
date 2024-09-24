import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/database/database_provider.dart';
import 'package:provider/provider.dart';

class ContentPost extends StatefulWidget {
  const ContentPost({super.key});

  @override
  State<ContentPost> createState() => _ContentPostState();
}

class _ContentPostState extends State<ContentPost> {
  final String _currentZone = 'C - 137';

  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  late final currUser = databaseProvider.currentUser;

  final _contentController = TextEditingController();

  Future<void> createPost(String contentText, String contentImgUrl) async {
    await databaseProvider.createPost(_currentZone, contentText, contentImgUrl);
  }

  // TODO handle post (no post on empty input, alert when posted, return to home)
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    // TODO ontap
                    //onTap: widget.onUserTap,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: currUser!.profileImgUrl.isNotEmpty
                          ? NetworkImage(currUser!.profileImgUrl)
                          : null,
                      backgroundColor: currUser!.profileImgUrl.isEmpty
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      child: currUser!.profileImgUrl.isEmpty
                          ? SvgPicture.asset(
                              'assets/icons/default_avatar.svg',
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.surface,
                                BlendMode.srcIn,
                              ),
                              width: 30,
                              height: 30,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        // TODO ontap
                        //onTap:
                        child: Text(
                          'ilovedanchu',
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Share with your neighbors...',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff818080),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'What\'s up?',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                ),
                controller: _contentController,
                maxLines: 6,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/camera.svg',
                          height: 23,
                          width: 26.93,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.inverseSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/photo.svg',
                          height: 23,
                          width: 23,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.inverseSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await createPost(_contentController.text, '');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Post',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
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
