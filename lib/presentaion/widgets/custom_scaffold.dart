import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget? appBarLeading;
  final Widget appBarActions;
  final Widget body;
  final Widget? bottomNavBar;
  final Widget? drawer;
  const CustomScaffold({
    super.key,
    required this.appBarTitle,
    this.appBarLeading,
    required this.appBarActions,
    required this.body,
    this.bottomNavBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 19, 14, 68),
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [appBarActions],
        leading: appBarLeading,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Clor.fromARGB(255, 21, 8, 40),
              Color.fromARGB(255, 19, 14, 68),
              Color.fromARGB(255, 9, 5, 56),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: body,
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
