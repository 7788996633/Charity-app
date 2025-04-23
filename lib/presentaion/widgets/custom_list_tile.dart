import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Function()? onTap;
  final Icon icon;
  final String title;
  final int maxlines;

  const CustomListTile(
      {super.key,
      this.onTap,
      required this.icon,
      required this.title,
      required this.maxlines});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(
        maxLines: maxlines,
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
