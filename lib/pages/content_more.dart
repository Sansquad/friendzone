import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/components/profile_content.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';

class ContentMore extends StatefulWidget {
  const ContentMore({super.key});

  @override
  State<ContentMore> createState() => _ContentMoreState();
}

class _ContentMoreState extends State<ContentMore> {
  final _auth = FirebaseAuthService();

  void logOut() {
    _auth.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 40, right: 40),
        child: SafeArea(
          child: Column(
            children: [
              ProfileContent(uid: _auth.getCurrentUid()),
              Divider(),
              ListTile(
                title: Text(
                  'My Posts',
                  style: TextStyle(
                    fontFamily: 'BigShouldersDisplay',
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Saved Posts',
                  style: TextStyle(
                    fontFamily: 'BigShouldersDisplay',
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'My Friendzone',
                  style: TextStyle(
                    fontFamily: 'BigShouldersDisplay',
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Sign out',
                  style: TextStyle(
                    fontFamily: 'BigShouldersDisplay',
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                splashColor: Colors.transparent,
                onTap: logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
