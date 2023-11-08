// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SomeButtons extends StatelessWidget {
  String text;
  VoidCallback onPressed;

  SomeButtons({super.key, required this.text, required this.onPressed});



  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
        color: Colors.yellow[200],
      child: 
        Text(text),
    );
  }
}