import 'package:flutter/material.dart';

import 'global_key.dart';

class Toast {
  static void success(String message) {
    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(96, 211, 175, 1.0),
                  border:
                      Border.all(color: const Color.fromRGBO(0, 70, 70, 1.0)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Stack(children: [
                Positioned(
                  left: 50,
                  top: 30,
                  child: ClipOval(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(48, 175, 134, 1),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: -100,
                  child: ClipOval(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(48, 175, 134, 1),
                      ),
                    ),
                  ),
                ),
                Padding(
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }

  static void error(String message) {
    //Color.fromRGBO(175, 45, 45, 1.0) Color.fromRGBO(240, 84, 84, 1.0)
    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(240, 84, 84, 1.0),
                border:
                    Border.all(color: const Color.fromRGBO(175, 45, 45, 1.0)),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Stack(children: [
              Positioned(
                left: 50,
                top: 30,
                child: ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(240, 24, 24, 1.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: -100,
                child: ClipOval(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(240, 24, 24, 1.0),
                    ),
                  ),
                ),
              ),
              Padding(
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
              ),
            ]),
          )));
  }

  static void message(String message) {
    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(51, 171, 255, 1.0),
                border:
                    Border.all(color: const Color.fromRGBO(19, 57, 247, 1.0)),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Stack(children: [
              Positioned(
                left: 50,
                top: 30,
                child: ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(0, 125, 226, 1.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: -100,
                child: ClipOval(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(0, 125, 226, 1.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outlined,
                      color: Color.fromRGBO(19, 57, 247, 1.0),
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
              ),
            ]),
          )));
  }
}
