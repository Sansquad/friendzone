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


// updated 2024 08 12
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/components/authentication/firebase_auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../widgets/form_container_widget.dart';

class GoogleInPage extends StatefulWidget {
  const GoogleInPage({Key? key}) : super(key: key);
  
  @override
  _GoogleInPageState createState() => _GoogleInPageState();
}

class _GoogleInPageState extends State<GoogleInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Implementing google authentication
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
  TextEditingController _usernameOrEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  ////////////////////////////////////////

  User? _user;

  // Implementing google authentication
  @override
  void dispose() {
    _usernameOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  ////////////////////////////////////////

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
      // body: _user != null ? _userInfo() : _googleSignInButton(),
      body: Container(
  color: Colors.white,
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
                    color: Colors.black,
                  ),
                ),
  TextSpan(
                  text: "zone",
                  style: TextStyle(
                    fontFamily: 'BigShouldersText',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF69B7FF),
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
                Checkbox(
                  value: false,
                  onChanged: (bool? newValue) {},
                ),
                Text (
                  'Remember me?',
                  style: TextStyle(
                    fontFamily: 'BigShouldersText',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            ),
          SizedBox(height: 5),
          SizedBox(
            width: 313,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                _signIn();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF69B7FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontFamily: 'BigShouldersDisplay',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
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
                  fontSize: 17,
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
            SocialButton(
              assetPath: 'assets/icons/apple_logo.png',
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
                    fontFamily: 'BigShoulderDisplay',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF818080),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/getstarted');
                  },
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                      fontFamily: 'BigShoulderDisplay',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF69B7FF),
                    ),
                    ),
                  ),
              ],
            ),
            SizedBox(height:120),
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

    void _signIn() async {
    String input = _usernameOrEmailController.text;
    String password = _passwordController.text;

    String? email;
    if (input.contains('@')) {
      email = input;
    } else {
      email = await _firebaseAuth.getEmailFromUsername(input);
    }

    if (email != null) {
      try {
        User? user = await _firebaseAuth.signInWithEmailAndPassword(email, password);
        if (user != null) {
          print('Sign in successful');
          if (mounted) {
            Navigator.pushNamed(context, '/contentlayout');
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

  const SocialButton({required this.assetPath, required this.text, required this.onPressed});

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
            color: Color(0xFFCECECE),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              assetPath,
              height: 24,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'BigShouldersDisplay',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
