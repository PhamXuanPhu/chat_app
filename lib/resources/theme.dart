import 'package:chat_app/resources/colors.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          centerTitle: true, backgroundColor: Color.fromRGBO(48, 175, 134, 1)),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
            color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
        headlineMedium: TextStyle(
            color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
      ),
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
      )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(48, 175, 134, 1),
        selectedItemColor: colorMain,
      ));

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      appBarTheme: const AppBarTheme(
          centerTitle: true, backgroundColor: Color.fromRGBO(37, 37, 37, 1)),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(color: Colors.white, fontSize: 15),
        headlineMedium: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
      ),
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
      )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black87,
          selectedItemColor: Colors.grey.shade800));
}
