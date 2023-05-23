// ignore_for_file: deprecated_member_use

import 'package:chat_app/resources/colors.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // màu message background
    toggleableActiveColor: const Color.fromRGBO(240, 240, 240, 1),
    // màu message text
    selectedRowColor: const Color.fromRGBO(30, 30, 30, 1),
    // màu background chat bar
    bottomAppBarColor: Colors.grey.shade400.withOpacity(0.3),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
          color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(
          color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 15),
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
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: colorMain),
          borderRadius: BorderRadius.circular(20))),
      backgroundColor: MaterialStateProperty.all<Color>(colorMain),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 12),
      ),
    )),
    iconTheme: IconThemeData(color: Colors.grey.shade600),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(48, 175, 134, 1),
      selectedItemColor: colorMain,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.black87, actionTextColor: Colors.white),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(30, 30, 30, 1),
    // màu message background
    toggleableActiveColor: const Color.fromRGBO(70, 70, 70, 1),
    // màu message text
    selectedRowColor: Colors.white,
    // màu background chat bar
    bottomAppBarColor: Colors.black38.withOpacity(0.3),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(30, 30, 30, 1),
        foregroundColor: Colors.white,
        elevation: 0),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 15),
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
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          side:
              const BorderSide(width: 1, color: Color.fromRGBO(70, 70, 70, 1)),
          borderRadius: BorderRadius.circular(20))),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color.fromRGBO(70, 70, 70, 1)),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 12),
      ),
    )),
    iconTheme: const IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.grey.shade800),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(30, 30, 30, 1),
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.white, actionTextColor: Colors.black87),
  );
}
