import 'package:flutter/material.dart';

class NavBarComponent extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const NavBarComponent(
      {super.key,
      required this.currentIndex,
      required this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.blueAccent,
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.local_fire_department_rounded), label: 'Best'),
        NavigationDestination(
            icon: Icon(Icons.add_box_outlined), label: 'Post'),
        NavigationDestination(
            icon: Icon(Icons.all_inbox_rounded), label: 'Archive'),
        NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More')
      ],
    );
  }
}
