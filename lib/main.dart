import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/firebase_options.dart';
import 'database/upload_dummy_data.dart';
import 'pages/authentication_email.dart';
import 'pages/authentication_home.dart';
import 'pages/authentication_profile.dart';
import 'pages/authentication_signin.dart';
import 'pages/authentication_start.dart';
import 'pages/content_layout.dart';
import 'pages/get_started_2_page.dart';
// import 'pages/google_map_testing.dart';
import 'pages/google_map_page.dart';
import 'pages/sign_in_2_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //print("UploadingData...");
  //await uploadDummyData();

  // Check if running in development mode (aka. not production)
  const bool isDevelopment = !bool.fromEnvironment('dart.vm.product');

  if (isDevelopment) {
    await _configureEmulators();
    await uploadDummyData();
  }

  runApp(const MyApp());
}

Future<void> _configureEmulators() async {
  const String host = 'localhost';

  FirebaseAuth.instance.useAuthEmulator(host, 9099);

  FirebaseFirestore.instance.settings = const Settings(
    host: 'localhost:8080',
    sslEnabled: false, // ask
    persistenceEnabled: true,
  );
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
        '/signin': (context) => SignInPage(),
        '/signin2': (context) => SignIn2Page(),
        '/getstarted': (context) => GetStartedPage(),
        '/getstarted2': (context) => GetStarted2Page(),
        '/checkyouremail': (context) => CheckYourEmailPage(),
        '/createyourprofile': (context) => CreateYourProfilePage(),
        // '/googlemaptesting': (context) => GoogleMapTestingPage(),
        '/googlemappage': (context) => GoogleMapPage(),
        '/contentlayout': (context) => ContentLayout(),
      },
    );
  }
}
