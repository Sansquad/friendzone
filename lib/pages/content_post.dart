import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentPost extends StatelessWidget {
  const ContentPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/bar_back_yellow.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bar_home.svg',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Grid C - 137',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.normal,
                        color: Color(0xff808080),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ilovedanchu',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                ),
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
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/photo.svg',
                          height: 23,
                          width: 23,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      //shape: RoundedRectangleBorder(
                      //borderRadius: BorderRadius.circular(10),
                      //),
                    ),
                    child: Text(
                      'Post',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.black,
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
