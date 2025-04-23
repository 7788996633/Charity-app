// ignore_for_file: constant_identifier_names

import 'package:baader/presentaion/screens/home/home.dart';
import 'package:flutter/material.dart';

const PrimaryColor = Color(0x009922ef);

Map<String, Color> lightThemeColors = {
  'primaryColor': const Color.fromARGB(255, 150, 92, 249),
  'backGround': Colors.white,
  'text': Colors.white,
  'icons': Colors.black
};

Map<String, Color> darkThemeColors = {
  'primaryColor': const Color.fromARGB(255, 69, 3, 184),
  'backGround': Colors.black,
  'text': Colors.white,
  'icons': Colors.white
};

Color? changeColors(String colorMapKey) {
  if (Home.lightMood) {
    return lightThemeColors[colorMapKey];
  } else {
    return darkThemeColors[colorMapKey];
  }
}

String myToken = '';
