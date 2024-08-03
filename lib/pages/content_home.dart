import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/post_widget.dart';

class ContentHome extends StatefulWidget {
  const ContentHome({super.key});

  @override
  State<ContentHome> createState() => _ContentHomeState();
}

class _ContentHomeState extends State<ContentHome> {
  final List<Map<String, String>> _posts = [
    {
      'username': 'Kusupman_David',
      'profileImgUrl':
          'https://image.api.playstation.com/cdn/UP0151/CUSA09971_00/FEs8B2BDAudxV3js6SM2t4vZ88vnxSi0.png?w=440&thumb=false',
      'timestamp': '30 minutes ago',
      'text':
          'I am so extremely hungry\nNo breakfast. 2 eggs for lunch. 10 hours of work.... Can’t wait to go home...',
      'location': 'Grid C - 137',
      'likes': '137',
      'comments': '69',
      'imageUrl': ''
    },
    {
      'username': 'ilovedanchu',
      'profileImgUrl':
          'https://image.api.playstation.com/cdn/UP0151/CUSA09971_00/0RcbL27NY6TiKznAHsJXUcALVKb4AMyM.png?w=440&thumb=false',
      'timestamp': '44 minutes ago',
      'text': 'Peaceful Tuesday',
      'location': 'Grid C - 137',
      'likes': '42',
      'comments': '27',
      'imageUrl':
          'https://moewalls.com/wp-content/uploads/2023/05/rengoku-death-kimetsu-no-yaiba-thumb.jpg' // Placeholder image URL
    },
    {
      'username': 'hellothisisxyz',
      'profileImgUrl':
          'https://i1.sndcdn.com/artworks-000244570678-1pbn82-t500x500.jpg',
      'timestamp': '4 hours ago',
      'text': 'watch this video\nhttps://www.youtube.com/watch?v=E8H-67ILaqc',
      'location': 'Grid C - 137',
      'likes': '12',
      'comments': '8',
      'imageUrl': ''
    },
    {
      'username': 'hiddenperson',
      'profileImgUrl':
          'https://preview.redd.it/wtc3gq9qhe041.jpg?auto=webp&s=59263396dfaccee7362a7d5dce235c2d1810a4cf',
      'timestamp': '6 hours ago',
      'text': 'damn you found me by scrolling are you flutter god',
      'location': 'Grid C - 137',
      'likes': '1',
      'comments': '2',
      'imageUrl': ''
    }
  ];

  String _currentZone = 'C - 137';

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
                'assets/icons/bar_home.svg',
                height: 27,
                width: 27,
              ),
              SizedBox(width: 12),
              Text(
                'Zone ' + _currentZone,
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
