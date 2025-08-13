import 'package:flutter/material.dart';

class RegularTextfield extends StatelessWidget {
  const RegularTextfield({super.key, required this.maxLength, required this.hintText, this.obscureText = false});

  final String hintText;
  final bool obscureText;
  final int maxLength;

  factory RegularTextfield.pass({required String hintText}) {
    return RegularTextfield(
      maxLength: 8,
      hintText: hintText,
      obscureText: true,
      );
  }


  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
    );
  }
}