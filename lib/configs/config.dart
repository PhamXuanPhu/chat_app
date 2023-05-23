import 'package:flutter/material.dart';

import '../models/user.dart';

class Config {
  Config._();
  static String accessToken = '';
  static String keyEmail = 'email';
  static String keyPassword = 'password';
  static String keyMode = 'mode';
  static String keyActiveStatus = 'activeStatus';
  static String keyLanguage = 'language';
  static String keyUserID = 'userId';
  static Locale english = const Locale('en', 'US');
  static Locale vietnamese = const Locale('vi', 'VN');
  static String enCode = 'en-US';
  static String vnCode = 'vi-VN';

  //API
  static String chatroooms = 'chatrooms';
  static String users = 'users';
  static String requests = 'requests';

  //data user
  static User user = User();
  static String password = '';
}
