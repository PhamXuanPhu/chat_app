import 'package:flutter/material.dart';

import '../../resources/colors.dart';

Widget buttonLogin(String text, VoidCallback onPressed) => OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      side: const BorderSide(width: 1, color: colorText),
    ),
    child: FittedBox(
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: colorText),
      ),
    ));
