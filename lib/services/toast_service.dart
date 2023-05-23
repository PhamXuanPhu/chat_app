import 'package:flutter/material.dart';

class Toast {
  static void message(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).snackBarTheme.backgroundColor,
              // border:
              //     Border.all(color: const Color.fromRGBO(0, 70, 70, 1.0)),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(
              message,
              style: TextStyle(
                  color: Theme.of(context).snackBarTheme.actionTextColor,
                  fontSize: 14),
            ),
          ),
        )));
  }
}
