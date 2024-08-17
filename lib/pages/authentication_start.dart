import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/services/database/database_service.dart';
// import 'package:friendzone/pages/authentication_start.dart';
import '../components/form_container_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetStartedPage extends StatefulWidget {
  final void Function()? onTap;

  const GetStartedPage({super.key, required this.onTap});

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final _db = DatabaseService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ValueNotifier<bool> _isPasswordInvalid = ValueNotifier(false);
  ValueNotifier<bool> _isPasswordValid = ValueNotifier(false);

  User? _user;

  // Check if password is valid (> 8 characters)
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _authInstance.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  void _validatePassword() {
    final password = _passwordController.text;
    if (password.length >= 8) {
      _isPasswordValid.value = true;
      _isPasswordInvalid.value = false;
    } else {
      _isPasswordValid.value = false;
      _isPasswordInvalid.value = true;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _isPasswordInvalid.dispose();
    _isPasswordValid.dispose();
    super.dispose();
  }

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
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        36, 0, 0, 20), // Adjust padding for positioning
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Get started with Friend',
                            style: TextStyle(
                              fontFamily: 'BigShouldersText',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                            ),
                          ),
                          TextSpan(
                            text: 'zone',
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
                  ),
                ),

                FormContainerWidget(
                  controller: _usernameController,
                  hintText: 'Username',
                  isPasswordField: false,
                ),
                SizedBox(height: 20),

                FormContainerWidget(
                  controller: _emailController,
                  hintText: 'Email Address',
                  isPasswordField: false,
                ),
                SizedBox(height: 20),

                FormContainerWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPasswordField: true,
                ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 46.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isPasswordInvalid,
                      builder: (context, isPasswordInvalid, child) {
                        return Text(
                          'Must be at least 8 characters',
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: isPasswordInvalid
                                ? Colors.red
                                : Color(0xFF818080),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ValueListenableBuilder<bool>(
                  valueListenable: _isPasswordValid,
                  builder: (context, isPasswordValid, child) {
                    return SizedBox(
                      width: 313,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isPasswordValid
                            ? () {
                                _signUp();
                                // Navigator.pushNamed(context, '/contentlayout');
                              }
                            : () {
                                _isPasswordInvalid.value = true;
                                // Optional: Implement buzzing effect here
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                // Adding "- or -", Google Sign in, Apple sign in
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
                  onPressed: () {
                    _handleAppleSignIn();
                  },
                ),
                SizedBox(height: 10),
                // Continue with Google button
                SocialButton(
                  assetPath: 'assets/icons/google_logo.png',
                  text: 'Continue with Google',
                  onPressed: () {
                    _handleGoogleSignIn();

                    // bongbong //
                  },
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    GestureDetector(
                      // onTap: widget.showSignInPage,
                      onTap: widget.onTap,
                      child: Text(
                        'Sign In',
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
                SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAppleSignIn() async {
    print('Apple Sign In is not supported yet');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Lol. Use email or Google to sign in.'),
      backgroundColor: Colors.red,
    ));
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
      // final UserCredential userCredential = await _auth.signInWithCredential(credential);
      UserCredential userCredential =
          await _authInstance.signInWithCredential(credential);
      // _user = userCredential.user;
      User? user = userCredential.user;

      // setState(() {});

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'username': user.displayName,
            'email': user.email,
            'createdAt': Timestamp.now(),
          });
          Navigator.pushNamed(context, '/createyourprofile');
        } else {
          Navigator.pushNamed(context, '/contentlayout');
        }
      }
    } catch (error) {
      print('Error during Google Sign-In: $error');
    }
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // 항목이 비어있는지 확인
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      print('All fields are required.');
      return;
    }

    try {
      // Check if the username exists
      QuerySnapshot usernameQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

      if (usernameQuery.docs.isNotEmpty) {
        // Username is taken
        print('Username is already taken');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Username is already taken'),
          backgroundColor: Colors.red,
        ));
        return;
      }
          
      // Check if the email already exists
      QuerySnapshot emailQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        // Email is taken
        print('Email is already taken');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Email is already taken'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      // If both are available -> create the user
      User? user = await _firebaseAuth.signUpWithEmailAndPassword(email, password);

      if (user != null) {

        // 만약 사용자의 추가적인 정보를 받고 싶다면 추가하기
        // 'users' collection에 저장됨
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'createdAt': Timestamp.now(),
        });

        // Send email verification
        await user.sendEmailVerification();
        if (mounted) {
          // Navigator.pushNamed(context, '/contentlayout');
          Navigator.pushNamed(context, '/verifyemail');
        }
      } else {
        print('Sign up failed');

        // Send email verification
      }
    } catch (e) {
      print('Failed to sign up: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign up: $e'),
        backgroundColor: Colors.red,
      ));
    }
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
