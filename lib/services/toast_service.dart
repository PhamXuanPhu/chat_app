import 'package:flutter/material.dart';

import 'global_key.dart';

class Toast {
  static void success(String message) {
    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(96, 211, 175, 1.0),
                  border: Border.all(color: Color.fromRGBO(0, 70, 70, 1.0)),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outlined,
                    color: Color.fromRGBO(0, 70, 70, 1.0),
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            )));
  }

  static void error(String message) {
    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(240, 84, 84, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outlined,
                  color: Color.fromRGBO(175, 45, 45, 1.0),
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          )));
  }
}
