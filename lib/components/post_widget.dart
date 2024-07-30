import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class PostWidget extends StatelessWidget {
  final Map<String, String> postData;

  const PostWidget({super.key, required this.postData});

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
                  backgroundImage: postData['profileImgUrl']!.isNotEmpty
                      ? NetworkImage(postData['profileImgUrl']!)
                      : null,
                  child: postData['profileImgUrl']!.isEmpty
                      ? Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postData['username']!,
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.w600,
                        //fontSize: 12,
                      ),
                    ),
                    Text(
                      postData['timestamp']!,
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.w300,
                        color: Color(0xff818080),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/post_bookmark.svg',
                  height: 14,
                  width: 14,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              postData['text']!,
              style: TextStyle(
                fontFamily: 'ABeeZee',
                fontWeight: FontWeight.normal,
                color: Color(0xff323232),
                fontSize: 13,
              ),
            ),
            if (postData['imageUrl']!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.network(postData['imageUrl']!),
              ),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/post_like.svg',
                      height: 14,
                      width: 14,
                    ),
                    SizedBox(width: 2),
                    Text(postData['likes']!),
                    SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/icons/post_comment.svg',
                      height: 14,
                      width: 14,
                    ),
                    SizedBox(width: 2),
                    Text(postData['comments']!),
                  ],
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/bar_home.svg',
                  height: 15,
                  width: 15,
                ),
                SizedBox(width: 5),
                Text(
                  postData['location']!,
                  style: TextStyle(
                      fontFamily: 'BigShouldersDisplay',
                      fontWeight: FontWeight.normal,
                      color: Color(0xff808080)
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
