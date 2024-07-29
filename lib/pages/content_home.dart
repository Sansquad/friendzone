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
      'timestamp': '30 minutes ago',
      'text':
          'I am so extremely hungry\nNo breakfast. 2 eggs for lunch. 10 hours of work.... Can’t wait to go home...',
      'location': 'Grid C - 137',
      'likes': '1',
      'comments': '6',
      'imageUrl': ''
    },
    {
      'username': 'ilovedanchu',
      'timestamp': '44 minutes ago',
      'text': 'Peaceful Tuesday',
      'location': 'Grid C - 137',
      'likes': '1',
      'comments': '6',
      'imageUrl':
          'https://moewalls.com/wp-content/uploads/2023/05/rengoku-death-kimetsu-no-yaiba-thumb.jpg' // Placeholder image URL
    },
    {
      'username': 'hellothisisxyz',
      'timestamp': '4 hours ago',
      'text': 'watch this video\nhttps://www.youtube.com/watch?v=E8H-67ILaqc',
      'location': 'Grid C - 137',
      'likes': '1',
      'comments': '6',
      'imageUrl': ''
    },
    {
      'username': 'hiddenperson',
      'timestamp': '4 hours ago',
      'text': 'damn you found me by scrolling are you flutter god',
      'location': 'Grid C - 137',
      'likes': '1',
      'comments': '6',
      'imageUrl': ''
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/bar_home.svg',
                  height: 27,
                  width: 27,
                ),
                SizedBox(width: 8),
                Text(
                  'Zone C - 137',
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
                  child: SvgPicture.asset('assets/icons/bar_map.svg'),
                ))
          ],
        ),
        body: ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              return PostWidget(postData: _posts[index]);
            }));
  }
}
