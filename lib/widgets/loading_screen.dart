import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../resources/assets.dart';

Container loadingScreen() => Container(
      color: Colors.transparent,
      // height: getHeight(),
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
    );
