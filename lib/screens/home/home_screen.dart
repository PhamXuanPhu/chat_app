import 'package:chat_app/screens/home/community_screen.dart';
import 'package:chat_app/screens/home/request_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_drawer.dart';
import '../../widgets/navigation_bar.dart';
import 'chats_screen.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var screens = [
    chat(),
    const ContactsScreen(),
    const RequestScreen(),
    const CommunityScreen()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(index == 0
            ? 'title_chat'.tr()
            : index == 1
                ? 'title_danh_ba'.tr()
                : index == 2
                    ? 'title_loi_moi'.tr()
                    : 'title_cong_dong'.tr()),
      ),
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          IndexedStack(
            index: index,
            children: screens,
          ),
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
