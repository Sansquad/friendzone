import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentChat extends StatefulWidget {
  const ContentChat({super.key});

  @override
  State<ContentChat> createState() => _ContentChatState();
}

class _ContentChatState extends State<ContentChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        //forceMaterialTransparency: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bar_chat.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
                height: 27,
                width: 27,
              ),
              SizedBox(width: 12),
              Text(
                'Messages',
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
