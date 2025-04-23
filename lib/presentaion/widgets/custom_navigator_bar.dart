import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class CustomNavigatorBar extends StatelessWidget {
  final ValueChanged<int> onTap;

  const CustomNavigatorBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      buttonBackgroundColor: const Color.fromARGB(255, 49, 42, 124),
      color: const Color.fromARGB(255, 11, 4, 81),
      backgroundColor: const Color.fromARGB(255, 54, 54, 55),
      items: const [
        CurvedNavigationBarItem(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: 'Home',
        ),
        CurvedNavigationBarItem(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          child: Icon(
            Icons.school,
            color: Colors.white,
          ),
          label: 'Learning',
        ),
        CurvedNavigationBarItem(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          child: Icon(
            Icons.article,
            color: Colors.white,
          ),
          label: 'Articles',
        ),
        CurvedNavigationBarItem(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          child: Icon(
            Icons.event_available,
            color: Colors.white,
          ),
          label: 'Events',
        ),
        CurvedNavigationBarItem(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          child: Icon(
            Icons.bar_chart_outlined,
            color: Colors.white,
          ),
          label: 'Statistics',
        ),
      ],
      onTap: onTap,
    );
  }
}
