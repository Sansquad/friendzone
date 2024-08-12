import 'package:flutter/material.dart';
import 'package:friendzone/components/nav_bar.dart';
import 'package:friendzone/pages/content_archive.dart';
import 'package:friendzone/pages/content_best.dart';
import 'package:friendzone/pages/content_home.dart';
import 'package:friendzone/pages/content_more.dart';
import 'package:friendzone/pages/content_post.dart';

class ContentLayout extends StatefulWidget {
  const ContentLayout({super.key});

  @override
  State<ContentLayout> createState() => _ContentLayoutState();
}

class _ContentLayoutState extends State<ContentLayout> {
  int _currentIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    ContentHome(),
    ContentBest(),
    ContentPost(),
    ContentArchive(),
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
