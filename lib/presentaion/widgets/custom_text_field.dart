import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.myController,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.validator,
    required this.focusNode,
    required this.textInputAction,
    this.onEditingComplete,
  });

  final TextEditingController myController;
  final String hintText;
  final String labelText;
  final Icon icon;
  final String? Function(String?) validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: myController,
      validator: validator,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        suffixIcon: icon,
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
