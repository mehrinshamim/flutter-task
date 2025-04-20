// lib/widgets/bottom_navigation.dart
import 'package:flutter/material.dart';

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
              icon: Icon(
                Icons.home,
                color:
                    currentIndex == 0 ? const Color(0xFF70B9BE) : Colors.grey,
              ),
              onPressed: () {
                if (currentIndex != 0) {
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color:
                    currentIndex == 1 ? const Color(0xFF70B9BE) : Colors.grey,
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
              icon: Icon(
                Icons.notifications,
                color:
                    currentIndex == 2 ? const Color(0xFF70B9BE) : Colors.grey,
              ),
              onPressed: () {
                if (currentIndex != 2) {
                  Navigator.of(context).pushReplacementNamed('/notifications');
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color:
                    currentIndex == 3 ? const Color(0xFF70B9BE) : Colors.grey,
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
