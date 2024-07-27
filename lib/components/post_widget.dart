import 'package:flutter/material.dart';

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
                  radius: 14.5,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postData['username']!,
                      style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(postData['timestamp']!,
                        style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontWeight: FontWeight.w300,
                            color: Color(0xff818080))),
                  ],
                ),
                Spacer(),
                Text(
                  postData['location']!,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(postData['text']!),
            if (postData['imageUrl']!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.network(postData['imageUrl']!),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up_off_alt, size: 20),
                    SizedBox(width: 5),
                    Text(postData['likes']!),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.comment, size: 20),
                    SizedBox(width: 5),
                    Text(postData['comments']!),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
