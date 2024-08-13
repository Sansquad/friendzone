import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            icon: SvgPicture.asset('assets/icons/bar_back_yellow.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 20),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xffD9D9D9),
                    child: Icon(Icons.person_add_alt,
                        color: Colors.white, size: 40),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'David Seong',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      'Kusupman_David',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
              child: Text(
                'Check out my youtube channel\nhttps://www.youtube.com/@Kusupman\nPlease like and subscribe!',
                style: TextStyle(
                  fontFamily: 'BigShouldersDisplay',
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 53, vertical: 10),
                  ),
                  child: Text(
                    'Edit profile',
                    style: TextStyle(
                      color: Color(0xff818080),
                      fontFamily: 'BigShouldersDisplay',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 53, vertical: 10),
                  ),
                  child: Text(
                    'Share profile',
                    style: TextStyle(
                      color: Color(0xff818080),
                      fontFamily: 'BigShouldersDisplay',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/profile_zone_num.svg',
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.inverseSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: Text(
                      '  Number of zones visited: 1344',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/profile_zone_hero.svg',
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: Text(
                      ' Zone hero: 633',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/profile_points.svg',
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.inverseSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: Text(
                      'Points: 512373',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'My Posts',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Saved Posts',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'My Friendzone',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Sign out',
                      style: TextStyle(
                        fontFamily: 'BigShouldersDisplay',
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    splashColor: Colors.transparent,
                    onTap: logOut,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
