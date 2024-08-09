import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/post_widget.dart';

class ContentArchive extends StatefulWidget {
  const ContentArchive({super.key});

  @override
  State<ContentArchive> createState() => _ContentArchiveState();
}

class _ContentArchiveState extends State<ContentArchive> {

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
      body:
      // TODO: implement archive page
      Column(),
      /*
      ListView.separated(
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
      ),*/
    );
  }
}
