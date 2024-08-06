import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/post_widget.dart';

class ContentBest extends StatefulWidget {
  const ContentBest({super.key});

  @override
  State<ContentBest> createState() => _ContentBestState();
}

class _ContentBestState extends State<ContentBest> {
  final List<Map<String, dynamic>> _posts = [
  {
    'gridCode': 'C - 137',
    'username': 'Belon Tusk',
    'profileImgUrl':
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Elon_Musk_Colorado_2022_%28cropped2%29.jpg/640px-Elon_Musk_Colorado_2022_%28cropped2%29.jpg',
    'timestamp': '30 minutes ago',
    'contentText':
    '**URGENT** how do i divide the earth into zones in flutter. help me dev gods',
    'likeNum': 120344,
    'commentNum': 2103,
    'contentImageUrl': ''
  },
  {
    'gridCode': 'A - 283',
    'username': 'MrEast',
    'profileImgUrl':
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCXjqOm-txYEsDyCtQdJCXlu6JFwHOaS8QoA&s',
    'timestamp': '44 minutes ago',
    'contentText':
    'i am testing for very looooooooooooooong looooooooooooooooooooooooooooooooooooooooooooooooooooooong looooooooooooooong contentText.',
    'likeNum': 10367,
    'commentNum': 6292,
    'contentImageUrl':
    'https://file.forms.app/sitefile/55+Hilarious-developer-memes-that-will-leave-you-in-splits-9.jpeg'
  },
  {
    'gridCode': 'D - 283',
    'username': 'hellothisisxyz',
    'profileImgUrl': '',
    'timestamp': '4 hours ago',
    'contentText': 'watch this video\nhttps://www.youtube.com/watch?v=9RZ2Y-IyK3g',
    'likeNum': 1123,
    'commentNum': 632,
    'contentImageUrl': ''
  },
  {
    'gridCode': 'C - 137',
    'username': 'hiddenperson',
    'profileImgUrl':
    'https://image.civitai.com/xG1nkqKTMzGDvpLrqFT7WA/a8a20233-d498-480a-bd8a-700a74374d35/width=1200/a8a20233-d498-480a-bd8a-700a74374d35.jpeg',
    'timestamp': '2 hours ago',
    'contentText': 'SPOILER ALERT how muzan dies',
    'likeNum': 300,
    'commentNum': 62,
    'contentImageUrl':
    'https://i.pinimg.com/736x/f9/06/a1/f906a1909dc27df0acedb174d18b6901.jpg'
  }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
              SizedBox(width: 12),
              Text(
                'Best of All Zones',
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
            //highlightColor: Colors.transparent,
            visualDensity: VisualDensity.compact,
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/bar_notification.svg'),
          ),
          IconButton(
            //highlightColor: Colors.transparent,
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SvgPicture.asset('assets/icons/bar_map.svg'),
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
