// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:friendzone/components/authentication/firebase_auth_services.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../widgets/form_container_widget.dart';
// import 'package:sign_in_button/sign_in_button.dart';

// class GoogleInPage extends StatefulWidget {
//   const GoogleInPage({super.key});
  
//   @override
//   _GoogleInPageState createState() => _GoogleInPageState();
// }

// class _GoogleInPageState extends State<GoogleInPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? _user;

//   @override
//     void initState() {
//       super.initState();
//       _auth.authStateChanges().listen((event) {
//         setState((){
//           _user =event;
//         });
//       });
//     }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushNamed(context, '/homepage');
//           },
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: _user != null ? _userInfo(): _googleSignInButton(),
//     );
//   }

//   Widget _googleSignInButton() {
//     return Center(
//       child: SizedBox(
//         height: 50,
//         child: SignInButton(
//           Buttons.google, 
//         text: "Sign up with Google", 
//         onPressed: _handleGoogleSignIn,
//         ),
//       ),
//     );
//   }

//   Widget _userInfo() {
//     return SizedBox();
//   }

//   void _handleGoogleSignIn() {
//     try{
//       GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
//       _auth.signInWithProvider(_googleAuthProvider);
//     } catch (Error) {
//       print(Error);
//     }
//   }

//   void _signIn() async {
//             Navigator.pushNamed(context, '/contentlayout');
//   }
// }


// GPT ver

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class GoogleInPage extends StatefulWidget {
  const GoogleInPage({Key? key}) : super(key: key);
  
  @override
  _GoogleInPageState createState() => _GoogleInPageState();
}

class _GoogleInPageState extends State<GoogleInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/homepage');
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign up with Google",
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  Widget _userInfo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_user?.photoURL != null)
            CircleAvatar(
              backgroundImage: NetworkImage(_user!.photoURL!),
              radius: 40,
            ),
          SizedBox(height: 16),
          Text('Name: ${_user?.displayName ?? 'Anonymous'}'),
          Text('Email: ${_user?.email ?? 'Not available'}'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _signOut,
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;

      setState(() {});

      // Navigate to the next screen
      Navigator.pushNamed(context, '/contentlayout');
    } catch (error) {
      print('Error during Google Sign-In: $error');
      // You could display a dialog or message to the user here
    }
  }

  void _signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    setState(() {
      _user = null;
    });
  }
}
