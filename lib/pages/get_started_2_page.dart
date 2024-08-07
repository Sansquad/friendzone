import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/components/authentication/firebase_auth_services.dart';
import '../components/form_container_widget.dart';

class GetStarted2Page extends StatefulWidget {
  @override
  _GetStarted2PageState createState() => _GetStarted2PageState();
}

class _GetStarted2PageState extends State<GetStarted2Page> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ValueNotifier<bool> _isPasswordInvalid = ValueNotifier(false);
  ValueNotifier<bool> _isPasswordValid = ValueNotifier(false);

  // Check if password is valid (> 8 characters)
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
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
            Navigator.pop(
                context); // Navigate back to the previous screen (home page)
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
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'zone',
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
                            color:
                                isPasswordInvalid ? Colors.red : Colors.black,
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
                          backgroundColor: Color(0xFF69B7FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontFamily: 'BigShouldersDisplay',
                            fontSize: 20,
                            fontWeight: FontWeight.w500, // Semibold
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),

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

                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
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
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' to Sign In',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.chevron_right,
                          color: Color(0xFF69B7FF),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print('Sign up successful');
      if (mounted) {
        Navigator.pushNamed(context, '/contentlayout');
      }
    } else {
      print('Sign up failed');
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
          padding: EdgeInsets.symmetric(
              horizontal: 12.0), // Adjust padding to align logos to the left
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
