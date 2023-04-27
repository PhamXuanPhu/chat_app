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
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutExpo,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              tabBackgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              gap: 5,
              color: colorWhite,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
              activeColor: colorWhite,
              tabs: [
                GButton(
                  padding: const EdgeInsets.all(14),
                  icon: Icons.question_answer,
                  text: 'title_chat'.tr(),
                ),
                GButton(
                  padding: const EdgeInsets.all(14),
                  icon: Icons.group,
                  text: 'title_danh_ba'.tr(),
                ),
                GButton(
                  padding: const EdgeInsets.all(14),
                  icon: Icons.person_add,
                  text: 'title_loi_moi'.tr(),
                ),
                GButton(
                  padding: const EdgeInsets.all(14),
                  icon: Icons.public,
                  text: 'title_cong_dong'.tr(),
                )
              ]),
        ),
      ),
    );
