import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:friendzone/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/database/initialize_best_posts.dart';
import 'package:friendzone/services/auth/auth_gate.dart';

import 'config/firebase_options.dart';
import 'database/upload_dummy_data.dart';

import 'pages/authentication_email.dart';
import 'pages/authentication_home.dart';
import 'pages/authentication_email.dart';
import 'pages/authentication_profile.dart';
import 'pages/authentication_start.dart';
import 'pages/authentication_signin.dart';

// import 'pages/google_map_testing.dart';
import 'pages/google_map_page.dart';

import 'pages/authentication_signin.dart';
import 'pages/authentication_start.dart';

import 'pages/content_layout.dart';
import 'theme/dark_mode.dart';
import 'theme/light_mode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Check if running in development mode (aka. not production)
  const bool isDevelopment = !bool.fromEnvironment('dart.vm.product');

  if (isDevelopment) {
    await _configureEmulators();
    await uploadDummyData();
    //await initializeBestPosts();
  }

  runApp(const MyApp());
}

Future<void> _configureEmulators() async {
  const String host = 'localhost';

  FirebaseAuth.instance.useAuthEmulator(host, 9099);

  FirebaseFirestore.instance.settings = const Settings(
    host: 'localhost:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //debugShowMaterialGrid: true,
      home: const AuthGate(),
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
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
