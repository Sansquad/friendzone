import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Sign in text
              Text(
                'Sign in',
                style: TextStyle(
                  fontFamily: 'BigShouldersText',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Email Address or Username TextField
              CustomTextField(
                hintText: 'Email Address or Username',
              ),
              SizedBox(height: 10),
              // Password TextField
              CustomTextField(
                hintText: 'Password',
              ),
              SizedBox(height: 10),
              // Remember me checkbox
              Row(
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Sign in button
              SizedBox(
                width: 313,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(

                    //primary: Color(0xFF69B7FF),
                    backgroundColor: Color(0xFF69B7FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text('Sign In'),
                ),
              ),
              SizedBox(height: 10),
              // Forgot Password
              Align(
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
              SizedBox(height: 20),
              // OR line
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Color(0xFF818080),
                      thickness: 2,
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
                      thickness: 2,
                      indent: 8,
                    ),
                  ),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      height: 47,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'BigShouldersDisplay',
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFFF0EDED),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFFF0EDED),
              width: 2,
            ),
          ),
        ),
      ),
    );
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: BorderSide(
            color: Color(0xFFCECECE),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 24,
            ),
            SizedBox(width: 10),
            Text(
              text,
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
    );
  }
}
