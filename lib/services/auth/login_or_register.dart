import 'package:flutter/material.dart';
import 'package:friendzone/pages/authentication_signin.dart';
import 'package:friendzone/pages/authentication_start.dart';

class LoginOrRegister extends StatefulWidget {
  final bool showLoginPage;
  const LoginOrRegister({super.key, required this.showLoginPage});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  late bool showLoginPage;

  @override
  void initState() {
    super.initState();
    showLoginPage = widget.showLoginPage;
  }

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return SignInPage(
        onTap: togglePages,
      );
    } else {
      return GetStartedPage(
        onTap: togglePages,
      );
    }
  }
}
