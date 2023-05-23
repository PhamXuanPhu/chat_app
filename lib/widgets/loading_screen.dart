import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../resources/assets.dart';

Widget loadingScreen() => Container(
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
    );
