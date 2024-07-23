//required
import 'package:flutter/material.dart';
import 'package:friendzone/pages/content_home_page.dart';

//import pages
import 'pages/home_page.dart';
import 'pages/sign_in_page.dart';

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
        home: const ContentHomePage(),
        routes: {
          '/signin': (context) => SignInPage(),
        });
  }
}
