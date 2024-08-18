import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
            highlightColor: Colors.transparent,
            icon: SvgPicture.asset(
              'assets/icons/bar_back.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/bar_edit_profile.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: 'BigShouldersText',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                radius: 37.5,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: SvgPicture.asset(
                  'assets/icons/default_avatar.svg',
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              'Edit profile picture',
              style: TextStyle(
                fontFamily: 'BigShouldersDisplay',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Theme.of(context)
                    .colorScheme
                    .inverseSurface
                    .withOpacity(0.9),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40),
            leading: Text(
              'Username',
              style: TextStyle(
                fontFamily: 'BigShouldersDisplay',
                fontSize: 20,
              ),
            ),
            title: Text(
              'My Posts',
              style: TextStyle(
                fontFamily: 'BigShouldersDisplay',
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
