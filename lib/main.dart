import 'package:firebase_core/firebase_core.dart';
import 'package:friendzone/firebase_options.dart'; 

import 'package:flutter/material.dart';
import 'package:friendzone/pages/content_layout.dart';
import 'pages/authentication_home.dart';
import 'pages/X_signin.dart';
import 'pages/X_start.dart';
import 'pages/authentication_email.dart';
import 'pages/authentication_profile.dart';
// import 'pages/google_map_testing.dart';
import 'pages/google_map_page.dart';

import 'pages/authentication_signin.dart';
import 'pages/authentication_start.dart';


import 'pages/content_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //debugShowMaterialGrid: true,
      home: HomePage(),
      routes: {
        '/homepage': (context) => HomePage(),
        '/signin' : (context) => SignInPage(),
        '/getstarted': (context) => GetStartedPage(),
        '/checkyouremail': (context) => CheckYourEmailPage(),
        '/createyourprofile': (context) => CreateYourProfilePage(),
        // '/googlemaptesting': (context) => GoogleMapTestingPage(),
        '/googlemappage': (context) => GoogleMapPage(),
        '/contentlayout': (context) => ContentLayout(),

      },
    );
  }
}
