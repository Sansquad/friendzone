import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:friendzone/components/authentication/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/form_container_widget.dart';

class SignIn2Page extends StatefulWidget {
  @override
  _SignIn2PageState createState() => _SignIn2PageState();
}

class _SignIn2PageState extends State<SignIn2Page> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  // take in either username/ email
  TextEditingController _usernameOrEmailController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
    void dispose() {
      _usernameOrEmailController.dispose();
      // _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  "Sign in",
                  style: TextStyle(
                    fontFamily: 'BigShouldersText',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                FormContainerWidget(
                  controller:_usernameOrEmailController,
                  // controller: _emailController,
                  hintText: 'Email Address or Username',
                  
                  isPasswordField: false,
                ),
                SizedBox(height: 20,),

                FormContainerWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPasswordField: true,
                ),
              // ],
                SizedBox(height: 20,),
                // Align "Remember me?" checkbox with the left side of the sign-in button
                Container(
                  width: 313,
                  child: Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? newValue) {},
                      ),
                      Text(
                        'Remember me?',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // Adjust color for better contrast
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Sign in button
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
        fontWeight: FontWeight.w300, // Semibold
        color: Colors.black,
      ),
    ),
  ),
),
                SizedBox(height: 10),
                // Align "Forgot Password?" with the right side of the sign-in button
                Container(
                  width: 313,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF818080),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // OR line with padding
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
                // Continue with Apple button
                SocialButton(
                  assetPath: 'assets/icons/apple_logo.png',
                  text: 'Continue with Apple',
                ),
                SizedBox(height: 10),
                // Continue with Google button
                SocialButton(
                  assetPath: 'assets/icons/google_logo.png',
                  text: 'Continue with Google',
                ),
                SizedBox(height: 20),
                // New to Friendzone? Click to Create Account >
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'New to Friend',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF818080),
                        ),
                      ),
                      TextSpan(
                        text: 'zone',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF69B7FF),
                        ),
                      ),
                      TextSpan(
                        text: '? ',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF818080),
                        ),
                      ),
                      TextSpan(
                        text: 'Click',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' to Create Account >',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                    
                  ),
                ),
                SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

 void _signIn() async{
    String input = _usernameOrEmailController.text;
    // String email = _emailController.text;
    String password = _passwordController.text;

    String? email;
    if (input.contains('@')) {
      email = input;
    } else {
      email = await _auth.getEmailFromUsername(input);
    }

 if (email != null) {
    try {

      User? user = await _auth.signInWithEmailAndPassword(email, password);
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
}


class SocialButton extends StatelessWidget {
  final String assetPath;
  final String text;

  const SocialButton({required this.assetPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 313,
      height: 47,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12.0), // Adjust padding to align logos to the left
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
