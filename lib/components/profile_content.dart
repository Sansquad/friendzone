import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendzone/database/database_provider.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ProfileContent extends StatefulWidget {
  final String uid;

  const ProfileContent({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  UserModel? user;
  String currentUid = FirebaseAuthService().getCurrentUid();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    user = await databaseProvider.userModel(widget.uid);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CircleAvatar(
                radius: 33,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: SvgPicture.asset(
                  'assets/icons/default_avatar.svg',
                  //height: 14,
                  //width: 14,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            Text(
              _isLoading ? '' : user!.username,
              style: TextStyle(
                fontFamily: 'BigShouldersDisplay',
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            _isLoading ? '' : user!.bio,
            style: TextStyle(
              fontFamily: 'BigShouldersDisplay',
              fontWeight: FontWeight.normal,
              fontSize: 17,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                  minimumSize: Size(0, 24),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    width: 2.0,
                  ),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontFamily: 'BigShouldersDisplay',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                  minimumSize: Size(0, 24),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    width: 2.0,
                  ),
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontFamily: 'BigShouldersDisplay',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
