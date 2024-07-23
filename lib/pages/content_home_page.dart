import 'package:flutter/material.dart';
import 'package:friendzone/components/nav_bar.dart';
import 'package:friendzone/pages/content_best_page.dart';

class ContentHomePage extends StatefulWidget {
  const ContentHomePage({super.key});

  @override
  State<ContentHomePage> createState() => _ContentHomePageState();
}

class _ContentHomePageState extends State<ContentHomePage> {
  int _currentIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text("Zone C-137"),
        titleTextStyle: TextStyle(
            fontFamily: 'BigShouldersText',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        centerTitle: false,
        leading: Icon(Icons.location_pin),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.map_outlined))],
      ),
      body: _getSelectedPage(_currentIndex),
      bottomNavigationBar: NavBarComponent(
        currentIndex: _currentIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text('Home Page'));
      case 1:
        return const ContentBestPage();
      case 2:
        return const Center(child: Text('Post Page'));
      case 3:
        return const Center(child: Text('Archive Page'));
      case 4:
        return const Center(child: Text('More Page'));
      default:
        return const Center(child: Text('Home Page'));
    }
  }
}
