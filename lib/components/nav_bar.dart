import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        NavigationDestination(
            icon: SvgPicture.asset(
              currentIndex == 0
                  ? 'assets/icons/nav_home_highlight.svg'
                  : 'assets/icons/nav_home.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home'),
        NavigationDestination(
            icon: SvgPicture.asset(
              currentIndex == 1
                  ? 'assets/icons/nav_best_highlight.svg'
                  : 'assets/icons/nav_best.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Best'),
        NavigationDestination(
            icon: SvgPicture.asset(
              currentIndex == 2
                  ? 'assets/icons/nav_post_highlight.svg'
                  : 'assets/icons/nav_post.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Post'),
        NavigationDestination(
            icon: SvgPicture.asset(
              currentIndex == 3
                  ? 'assets/icons/nav_archive_highlight.svg'
                  : 'assets/icons/nav_archive.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Archive'),
        NavigationDestination(
            icon: SvgPicture.asset(
              currentIndex == 4
                  ? 'assets/icons/nav_more_highlight.svg'
                  : 'assets/icons/nav_more.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'More'),
      ],
    );
  }
}
