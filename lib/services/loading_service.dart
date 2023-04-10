import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../resources/assets.dart';
import 'global_key.dart';

class Loading {
  void show() {
    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(initSnackBar());
  }

  void hide() async {
    await Future.delayed(const Duration(milliseconds: 100));
    ScaffoldMessenger.of(GlobalVariable.navigatorKey.currentContext!)
        .hideCurrentSnackBar();
  }

  SnackBar initSnackBar() => SnackBar(
      duration: const Duration(days: 1),
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        color: Colors.transparent,
        height: getHeight(),
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
      ));

  double getHeight() {
    final keyboardHeight =
        MediaQuery.of(GlobalVariable.navigatorKey.currentContext!)
            .viewInsets
            .bottom;
    final screenHeight =
        MediaQuery.of(GlobalVariable.navigatorKey.currentContext!).size.height;
    return screenHeight - keyboardHeight;
  }
}
