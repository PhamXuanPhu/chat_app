import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/resources/colors.dart';
import 'package:chat_app/screens/home/contact_screen.dart';
import 'package:chat_app/screens/home/user_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../widgets/navigation_bar.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var screens = [chat(), contact(), chat(), user()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'title_home'.tr(),
        ),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: index,
            children: screens,
          ),
          //   screens[index],
          bottomNavigationBar(context, (ind) {
            setState(() {
              index = ind;
            });
          })
        ],
      ),
    );
  }
}
