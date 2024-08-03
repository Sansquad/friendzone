import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateYourProfilePage extends StatefulWidget {
  @override
  _CreateYourProfilePageState createState() => _CreateYourProfilePageState();
}

class _CreateYourProfilePageState extends State<CreateYourProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 55, 0, 20), // Adjust padding for positioning
                    child: Text(
                      'Create your profile',
                      style: TextStyle(
                        fontFamily: 'BigShouldersText',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: 173,
                      height: 173,
                      decoration: BoxDecoration(
                        color: Color(0xFF69B7FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 50,
                      child: SvgPicture.asset(
                        'assets/icons/avatar_placeholder.svg', // Ensure the path is correct
                        width: 73,
                        height: 73,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0EDED),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/camera.svg', // Ensure the path is correct
                            width: 20.43,
                            height: 15.71,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Tell others a little about yourself',
                    style: TextStyle(
                      fontFamily: 'BigShouldersDisplay',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF818080),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Username',
                  suffixText: '*',
                  suffixTextColor: Color(0xFF69B7FF),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Nickname',
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Bio',
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 147,
                  height: 47,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your next action here
                      //changed from welcometofriendzone to googlemappage for testing
                      // Navigator.pushNamed(context, '/googlemappage');
                      Navigator.pushNamed(context, '/googlemappage');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF69B7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 20,
                        fontWeight: FontWeight.w600, // Semibold
                        color:Colors.black,
                      ),
                    ),
                  ),         
                ),
                SizedBox(height: 300),
                Padding(
                padding: EdgeInsets.only(bottom: 200),
                 ), // Additional padding at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? suffixText;
  final Color? suffixTextColor;

  const CustomTextField({
    required this.hintText,
    this.suffixText,
    this.suffixTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      height: 47,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'BigShouldersDisplay',
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFFF0EDED),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFFF0EDED),
              width: 2,
            ),
          ),
          suffixIcon: suffixText != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Text(
                    suffixText!,
                    style: TextStyle(
                      color: suffixTextColor ?? Colors.black,
                      fontFamily: 'BigShouldersDisplay',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
