import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/post_widget.dart';

class ContentArchive extends StatefulWidget {
  const ContentArchive({super.key});

  @override
  State<ContentArchive> createState() => _ContentArchiveState();
}

class _ContentArchiveState extends State<ContentArchive> {
  final List<Map<String, String>> _posts = [
    {
      'username': 'Kusupman_David',
      'profileImgUrl': '',
      'timestamp': '30 minutes ago',
      'text':
          '**URGENT** how do i divide the earth into zones in flutter. help me dev gods',
      'location': 'Grid C - 137',
      'likes': '120344',
      'comments': '2103',
      'imageUrl': ''
    },
    {
      'username': 'Kusupman_David',
      'profileImgUrl': '',
      'timestamp': '44 minutes ago',
      'text':
          'this is a test for very looooooooooooooong looooooooooooooong looooooooooooooong looooooooooooooong text.',
      'location': 'Grid A - 283',
      'likes': '10367',
      'comments': '6292',
      'imageUrl':
          'https://file.forms.app/sitefile/55+Hilarious-developer-memes-that-will-leave-you-in-splits-9.jpeg'
    },
    {
      'username': 'Kusupman_David',
      'profileImgUrl': '',
      'timestamp': '4 hours ago',
      'text': 'watch this video\nhttps://www.youtube.com/watch?v=9RZ2Y-IyK3g',
      'location': 'Grid D - 283',
      'likes': '1123',
      'comments': '632',
      'imageUrl': ''
    },
    {
      'username': 'Kusupman_David',
      'profileImgUrl': '',
      'timestamp': '4 hours ago',
      'text': 'SPOILER ALERT how muzan dies',
      'location': 'Grid C - 137',
      'likes': '1',
      'comments': '6',
      'imageUrl':
          'https://i.pinimg.com/736x/f9/06/a1/f906a1909dc27df0acedb174d18b6901.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bar_archive.svg',
                height: 27,
                width: 27,
              ),
              SizedBox(width: 12),
              Text(
                'My Posts',
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
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SvgPicture.asset('assets/icons/bar_notification.svg'),
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: _posts.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Color(0xff999999),
          height: 0,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        itemBuilder: (context, index) {
          return PostWidget(postData: _posts[index]);
        },
      ),
    );
  }
}
