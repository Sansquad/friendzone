import 'package:flutter/material.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isPasswordInvalid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      _isPasswordValid.value = _passwordController.text.length >= 8;
      _isPasswordInvalid.value = false;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _isPasswordValid.dispose();
    _isPasswordInvalid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen (home page)
          },
        ),
        backgroundColor: Colors.transparent,
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
                    padding: const EdgeInsets.fromLTRB(36, 0, 0, 20), // Adjust padding for positioning
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
                CustomTextField(
                  hintText: 'Username',
                  obscureText: false,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Email Address',
                  obscureText: false,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Password',
                  obscureText: _obscureText,
                  controller: _passwordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
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
                            color: isPasswordInvalid ? Colors.red : Colors.black,
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
                                Navigator.pushNamed(context, '/checkyouremail');
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
                            fontWeight: FontWeight.w600, // Semibold
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 313,
      height: 47,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
