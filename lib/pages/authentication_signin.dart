import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/services/auth/auth_gate.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../components/form_container_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/form_container_widget.dart';

class SignInPage extends StatefulWidget {
  final void Function()? onTap;
  const SignInPage({super.key, required this.onTap});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
  TextEditingController _usernameOrEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  User? _user;

  // Implementing google authentication
  @override
  void dispose() {
    _usernameOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  ////////////////////////////////////////

//  @override
//  void initState() {
//    super.initState();
//    _auth.authStateChanges().listen((event) {
//      setState(() {
//        _user = event;
//      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context)
            .colorScheme
            .surface, // Use the theme's surface color
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      // body: _user != null ? _userInfo() : _googleSignInButton(),
      body: Container(
        color: Theme.of(context)
            .colorScheme
            .surface, // Use the theme's surface color

        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome back to Friend",
                        style: TextStyle(
                          fontFamily: 'BigShouldersText',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                      TextSpan(
                        text: "zone",
                        style: TextStyle(
                          fontFamily: 'BigShouldersText',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                FormContainerWidget(
                  controller: _usernameOrEmailController,
                  hintText: 'Email Address or Username',
                  isPasswordField: false,
                ),
                SizedBox(height: 15),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPasswordField: true,
                ),
                SizedBox(height: 5),
                Container(
                  width: 313,
                  child: Row(
                    children: [
                      // don't think we'll need remember me 20240813
                      //               Checkbox(
                      //                 value: false,
                      //                 onChanged: (bool? newValue) {},
                      //                 activeColor: Color(0xFF818080),
                      //                 checkColor: Theme.of(context).colorScheme.primary,
                      //                 side: BorderSide(
                      //                   color: Color(0xFF818080), // Border color when not checked
                      //                   width: 2.0, // Border width
                      // ),
                      //               ),
                      //               Text (
                      //                 'Remember me?',
                      //                 style: TextStyle(
                      //                   fontFamily: 'BigShouldersText',
                      //                   fontSize: 17,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: Color(0xFF818080),                  ),
                      //               ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 313,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 23,
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 313,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'BigShoulderDisplay',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF818080),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Color(0xFF818080),
                          thickness: 1,
                          endIndent: 8,
                        ),
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF818080),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xFF818080),
                          thickness: 1,
                          indent: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Sign in with apple needs a paid Apple Developer account
                // 2024 08 13
                SocialButton(
                  assetPath: 'assets/icons/auth_apple.svg',
                  text: 'Continue with Apple',
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                SocialButton(
                  assetPath: 'assets/icons/google_logo.png',
                  text: 'Continue with Google',
                  onPressed: () {
                    _handleGoogleSignIn();
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New to Friendzone? ',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
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
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _user = userCredential.user;

      setState(() {});

      // Navigate to the next screen
      Navigator.pushNamed(context, '/contentlayout');
    } catch (error) {
      print('Error during Google Sign-In: $error');
      // You could display a dialog or message to the user here
    }
  }

  void _signIn() async {
    String input = _usernameOrEmailController.text;
    String password = _passwordController.text;

    String? email;

    if (input.contains('@')) {
      // user signed in with email address
      email = input;
    } else {
      // user is signing in with username
      email = await _getEmailFromUsername(input);
    }

    if (email != null) {
      try {
        User? user =
            await _firebaseAuth.signInWithEmailAndPassword(email, password);
        if (user != null) {
          print('Sign in successful');
          if (mounted) {
            //Navigator.pushNamed(context, '/contentlayout');
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        } else {
          print('Sign in failed: User is null');
        }
      } on FirebaseAuthException catch (e) {
        print('Sign in failed: ${e.message}');
      } catch (e) {
        print('Sign in failed: $e');
      }
    } else {
      print('No user found for that username.');
      return;
    }

    try {
      User? user =
          await _firebaseAuth.signInWithEmailAndPassword(email, password);

      if (user != null) {
        await user.reload();
        if (user.emailVerified) {
          // Email verified
          print('Sign in successful');
          Navigator.pushNamed(context, '/contentlayout');
        } else {
          // Email not verified
          print('Please verify email to continue');
          await _auth.signOut();
          Navigator.pushNamed(context, '/verifyemail');
        }
      } else {
        print('Sign in failed: User is null');
      }
    } on FirebaseAuthException catch (e) {
      print('Sign in failed: ${e.message}');
    } catch (e) {
      print('Sign in failed: $e');
    }

    // if (email != null) {
    //   try {
    //     User? user = await _firebaseAuth.signInWithEmailAndPassword(email, password);
    //     if (user != null) {
    //       print('Sign in successful');
    //       if (mounted) {
    //         Navigator.pushNamed(context, '/contentlayout');
    //       }
    //     } else {
    //       print('Sign in failed: User is null');
    //     }
    //   } on FirebaseAuthException catch (e) {
    //     print('Sign in failed: ${e.message}');
    //   } catch (e) {
    //     print('Sign in failed: $e');
    //   }
    // } else {
    //   print('No user found for that username.');
    // }
  }

  Future<String?> _getEmailFromUsername(String username) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.first.get('email') as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting email from username: $e');
      return null;
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

class SocialButton extends StatelessWidget {
  final String assetPath;
  final String text;
  final VoidCallback onPressed;

  const SocialButton(
      {required this.assetPath, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 313,
      height: 47,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: BorderSide(
            color: Color(0xFFF0EDED),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            if (assetPath.endsWith('.png'))
              Image.asset(
                assetPath, // Ensure the image exists in this path
                height: 24,
              ),
            if (assetPath.endsWith('.svg'))
              SvgPicture.asset(
                assetPath, // Ensure the image exists in this path
                height: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.inverseSurface,
                  BlendMode.srcIn,
                ),
              ),
            SizedBox(width: 0),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'BigShouldersDisplay',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
