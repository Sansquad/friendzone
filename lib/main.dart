//required
import 'package:flutter/material.dart';
import 'package:friendzone/pages/content_layout.dart';

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
        //debugShowMaterialGrid: true,
        home: const ContentLayout(),
        routes: {
          '/signin': (context) => SignInPage(),
        });
  }
}
