import 'package:chat_app/resources/colors.dart';
import 'package:flutter/material.dart';

enum ButtonStyleCustom { main, white }

Widget buttonCustom(String text, VoidCallback onPressed,
        {ButtonStyleCustom style = ButtonStyleCustom.main}) =>
    ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor:
                style == ButtonStyleCustom.main ? colorMain : colorWhite,
            minimumSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: colorMain),
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          style: TextStyle(
              color: style == ButtonStyleCustom.main ? colorWhite : colorMain,
              fontSize: 14),
        ));
