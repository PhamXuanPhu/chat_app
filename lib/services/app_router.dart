import 'package:chat_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../screens/chat/chat_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return null;
    }
  }
}
