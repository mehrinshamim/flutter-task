// lib/widgets/bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({Key? key, required this.currentIndex})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 8.0,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                currentIndex == 0
                    ? 'assets/icons/Home-Filled.svg'
                    : 'assets/icons/Home.svg',

                height: 24, // Adjust size as needed
                width: 24,
              ),
              onPressed: () {
                if (currentIndex != 0) {
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                currentIndex == 1
                    ? 'assets/icons/Search-Filled.svg'
                    : 'assets/icons/Search.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 1 ? const Color(0xFF70B9BE) : Colors.grey,
                  BlendMode.srcIn,
                ),
                height: 24,
                width: 24,
              ),
              onPressed: () {
                if (currentIndex != 1) {
                  Navigator.of(context).pushReplacementNamed('/search');
                }
              },
            ),
            // This is where the FAB will be placed
            const SizedBox(width: 48),
            IconButton(
              icon: SvgPicture.asset(
                currentIndex == 2
                    ? 'assets/icons/Notification-Filled.svg'
                    : 'assets/icons/Notification.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 2 ? const Color(0xFF70B9BE) : Colors.grey,
                  BlendMode.srcIn,
                ),
                height: 24,
                width: 24,
              ),
              onPressed: () {
                if (currentIndex != 2) {
                  Navigator.of(context).pushReplacementNamed('/notifications');
                }
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                currentIndex == 3
                    ? 'assets/icons/Profile-Filled.svg'
                    : 'assets/icons/Profile.svg',
                height: 24,
                width: 24,
              ),
              onPressed: () {
                if (currentIndex != 3) {
                  Navigator.of(context).pushReplacementNamed('/account');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
