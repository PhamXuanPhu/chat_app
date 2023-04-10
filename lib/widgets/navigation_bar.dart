import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../resources/colors.dart';

Widget bottomNavigationBar(BuildContext context, Function(int) onTabChange) =>
    Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: GNav(
              onTabChange: onTabChange,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutExpo,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              tabBackgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              gap: 8,
              color: colorWhite,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
              activeColor: colorWhite,
              tabs: [
                GButton(
                  icon: Icons.question_answer_outlined,
                  text: 'title_chat'.tr(),
                ),
                GButton(
                  icon: Icons.people_outline,
                  text: 'title_danh_ba'.tr(),
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.account_circle_outlined,
                  text: 'title_ho_so'.tr(),
                )
              ]),
        ),
      ),
    );