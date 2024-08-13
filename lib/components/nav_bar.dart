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
              'assets/icons/nav_home.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home'),
        NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/nav_best.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                BlendMode.srcIn,
              ),
            ),
            label: 'Best'),
        NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/nav_post.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 2
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                BlendMode.srcIn,
              ),
            ),
            label: 'Post'),
        NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/nav_chat.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 3
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                BlendMode.srcIn,
              ),
            ),
            label: 'Archive'),
        NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/nav_more.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 4
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                BlendMode.srcIn,
              ),
            ),
            label: 'More'),
      ],
    );
  }
}
