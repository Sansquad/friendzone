//required 
import 'package:flutter/material.dart';

//import pages
import 'pages/homepage.dart';
import 'pages/signin.dart';
import 'pages/get_started.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/signin': (context) => SignInPage(),
        '/getstarted': (context) => GetStartedPage(), // Added route

      },
    );
  }
}

