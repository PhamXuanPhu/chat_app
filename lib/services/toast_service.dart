import 'package:flutter/material.dart';

class Toast {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(39, 39, 39, 1.0),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: const EdgeInsets.all(10),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        )));
  }
}
