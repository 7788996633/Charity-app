import 'dart:ui';

import 'package:flutter/material.dart';

class CustomContainar extends StatelessWidget {
  const CustomContainar({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: child),
      ),
    );
  }
}
