import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../resources/assets.dart';

class Loading {
  static OverlayEntry? loadingScreen =
      OverlayEntry(builder: (BuildContext context) {
    return Positioned.fill(
        child: SafeArea(
      child: Container(
        color: const Color.fromRGBO(51, 51, 51, 0.4),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(39, 39, 39, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: 75,
            height: 75,
            child: const RiveAnimation.asset(
              Rives.loading,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    ));
  });

  static show(BuildContext context) {
    Overlay.of(context).insert(loadingScreen!);
  }

  static hide() {
    loadingScreen?.remove();
  }
}
