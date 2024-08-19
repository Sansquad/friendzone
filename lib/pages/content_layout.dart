import 'package:flutter/material.dart';
import 'package:friendzone/components/nav_bar.dart';
import 'package:friendzone/database/database_provider.dart';
import 'package:friendzone/pages/content_chat.dart';
import 'package:friendzone/pages/content_best.dart';
import 'package:friendzone/pages/content_home.dart';
import 'package:friendzone/pages/content_more.dart';
import 'package:friendzone/pages/content_post.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';
import 'package:provider/provider.dart';

class ContentLayout extends StatefulWidget {
  const ContentLayout({super.key});

  @override
  State<ContentLayout> createState() => _ContentLayoutState();
}

class _ContentLayoutState extends State<ContentLayout> {
  @override
  void initState() {
    super.initState;
    _preloadData();
  }

  Future<void> _preloadData() async {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    final authService = FirebaseAuthService();
    final uid = authService.getCurrentUid();

    await databaseProvider.loadAllData(uid, 'C - 137');
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    ContentHome(),
    ContentBest(),
    ContentPost(),
    ContentChat(),
    ContentMore(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _pages[_currentIndex],
      bottomNavigationBar: NavBarComponent(
        currentIndex: _currentIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
