import 'package:flutter/material.dart';

enum ButtonStyleCustom { main, white }

Widget buttonCustom(String text, VoidCallback onPressed) => ElevatedButton(
    onPressed: onPressed,
    child: FittedBox(
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    ));

Widget buttonCustom2(String text, VoidCallback onPressed) => OutlinedButton(
    onPressed: onPressed,
    child: FittedBox(
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    ));
