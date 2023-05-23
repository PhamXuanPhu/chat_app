import 'package:flutter/material.dart';

Widget myButton(String text, VoidCallback onPressed) => ElevatedButton(
    onPressed: onPressed,
    child: FittedBox(
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    ));
