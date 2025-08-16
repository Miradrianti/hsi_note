import 'package:flutter/material.dart';

class RegularTextfield extends StatefulWidget {
  const RegularTextfield({
    super.key, 
    required this.maxLength, 
    required this.hintText, 
    this.obscureText = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });
  

  final String hintText;
  final bool obscureText;
  final int maxLength;
  final TextEditingController controller;
  final TextInputType keyboardType;
  

  factory RegularTextfield.pass({
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text
  }) {
    return RegularTextfield(
      maxLength: 8,
      hintText: hintText,
      obscureText: true,
      controller: controller,
      keyboardType: keyboardType,
    );
  }

  @override
  State<RegularTextfield> createState() => _RegularTextfieldState();
}

class _RegularTextfieldState extends State<RegularTextfield> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText,
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