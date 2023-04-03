import 'package:chat_app/resources/colors.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme:
          const AppBarTheme(centerTitle: true, backgroundColor: colorMain),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colorMain),
        foregroundColor: MaterialStateProperty.all<Color>(colorWhite),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(35),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(35)),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: colorMain),
            borderRadius: BorderRadius.circular(10))),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colorWhite),
        foregroundColor: MaterialStateProperty.all<Color>(colorMain),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(35),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(35)),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: colorMain),
            borderRadius: BorderRadius.circular(10))),
      )));

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black87,
      appBarTheme:
          const AppBarTheme(centerTitle: true, backgroundColor: colorMain),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colorWhite),
        foregroundColor: MaterialStateProperty.all<Color>(colorMain),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(35),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(35)),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: colorMain),
            borderRadius: BorderRadius.circular(10))),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colorMain),
        foregroundColor: MaterialStateProperty.all<Color>(colorWhite),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(35),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(35)),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: colorMain),
            borderRadius: BorderRadius.circular(10))),
      )));
}
