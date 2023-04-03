import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../resources/assets.dart';
import 'global_key.dart';

class Loading {
  static void show() {
    final keyboardHeight =
        MediaQuery.of(GlobalVariable.navigatorKey.currentContext!)
            .viewInsets
            .bottom;
    final screenHeight =
        MediaQuery.of(GlobalVariable.navigatorKey.currentContext!).size.height;
    final availableHeight = screenHeight - keyboardHeight;

    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
            duration: const Duration(days: 1),
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              color: Colors.transparent,
              height: availableHeight,
              child: Center(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(39, 39, 39, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 100,
                    width: 100,
                    child: const RiveAnimation.asset(
                      Rives.loading,
                      alignment: Alignment.bottomCenter,
                    )),
              ),
            )));
  }

  static void hide() {
    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
        .removeCurrentSnackBar();
  }
}
