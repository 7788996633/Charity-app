import 'package:baader/presentaion/screens/home/home_screen.dart';
import 'package:baader/presentaion/screens/stat_screen.dart';
import 'package:baader/presentaion/widgets/custom_navigator_bar.dart';
import 'package:flutter/material.dart';

import '../articles/articles_screen.dart';
import '../courses/courses_screen.dart';
import '../events/events_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static bool lightMood = true;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> screensList = const [
    HomeScreen(),
    CoursesScreen(),
    ArticlesScreen(),
    EventsScreen(),
    StatisticsScreen(),
  ];

  void changeMood() {
    setState(() {
      Home.lightMood = !Home.lightMood;
    });
  }

  void onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[_currentIndex],
      bottomNavigationBar: CustomNavigatorBar(
        onTap: onNavTap,
      ),
    );
  }
}
