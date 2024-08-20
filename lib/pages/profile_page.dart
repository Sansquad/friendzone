import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/profile_content.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({
    super.key,
    required this.uid,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            ProfileContent(uid: widget.uid),
          ],
        ),
      ),
    );
  }
}
