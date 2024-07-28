import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/signin.dart';
import 'pages/get_started.dart';
import 'pages/checkyouremail.dart';
import 'pages/createyourprofile.dart';
import 'pages/welcometofriendzone.dart';
import 'pages/google_map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/signin': (context) => SignInPage(),
        '/getstarted': (context) => GetStartedPage(),
        '/checkyouremail': (context) => CheckYourEmailPage(), 
        '/createyourprofile': (context) => CreateYourProfilePage(), 
        '/welcometofriendzone': (context) => WelcomeToFriendZonePage(),
        '/googlemappage': (context) => GoogleMapPage(),
      },
    );
  }
}
