import 'package:flutter/material.dart';

Widget iconButton(
        {required BuildContext context,
        required IconData icon,
        required VoidCallback onPressed}) =>
    Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: Theme.of(context).toggleableActiveColor,
          borderRadius: BorderRadius.circular(20)),
      child: IconButton(
        icon: Icon(
          icon,
          size: 20,
          color: Theme.of(context).selectedRowColor,
        ),
        onPressed: onPressed,
        padding: const EdgeInsets.all(0),
        splashRadius: 10,
      ),
    );
