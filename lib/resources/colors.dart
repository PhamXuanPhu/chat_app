import 'package:chat_app/configs/config.dart';
import 'package:chat_app/helper/data_helper.dart';
import 'package:flutter/material.dart';

class Mode {
  Mode() {
    init();
  }
  static bool light = true;
  static void init() async {
    light = await DataHelper().getData(Config.keyMode);
  }
}

const colorMain = Color.fromRGBO(96, 211, 175, 1.0);
const colorWhite = Colors.white;
const colorBlack = Colors.black;
const colorRed = Colors.red;
