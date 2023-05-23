// ignore_for_file: deprecated_member_use

import 'package:chat_app/blocs/setting/setting_bloc.dart';
import 'package:chat_app/screens/setting/language_screen.dart';
import 'package:chat_app/screens/setting/mode_screen.dart';
import 'package:chat_app/screens/setting/notification_screen.dart';
import 'package:chat_app/widgets/avatar_template.dart';
import 'package:chat_app/widgets/icon_button.dart';
import 'package:chat_app/widgets/loading_screen.dart';
import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/firebase.dart';
import '../blocs/user/user_bloc.dart';
import '../configs/config.dart';
import '../screens/login/login_screen.dart';
import '../screens/setting/active_status_screen.dart';
import '../screens/setting/setting_screen.dart';
import '../services/data_service.dart';
import '../services/global_key.dart';
import 'my_button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);
    if (bloc.state.currentUser.id.isEmpty) {
      bloc.add(const LoadCurrentUser());
    }

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<UserBloc, UserState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is UserLoaded) {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 35,
                            width: 35,
                            child:
                                avatarTemplate(url: state.currentUser.avatar)),
                        width10(),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                state.currentUser.name,
                                style: const TextStyle(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        iconButton(
                            context: context,
                            icon: Icons.settings,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingScreen()),
                              );
                            }),
                      ],
                    ),
                    height10(value: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ModeScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          icon(
                            icon: Icons.dark_mode,
                            backgroundColor:
                                Theme.of(context).toggleableActiveColor,
                            iconColor: Theme.of(context).selectedRowColor,
                          ),
                          width10(),
                          title(
                              title: 'che_do'.tr(),
                              value: state.currentUser.mode
                                  ? 'toi'.tr()
                                  : 'sang'.tr()),
                        ],
                      ),
                    ),
                    height10(value: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ActiveStatusScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          icon(
                              icon: Icons.radio_button_on,
                              backgroundColor:
                                  const Color.fromRGBO(69, 213, 90, 1),
                              iconColor: Colors.white),
                          width10(),
                          title(
                              title: 'trang_thai_hoat_dong'.tr(),
                              value: state.currentUser.active_status
                                  ? 'bat'.tr()
                                  : 'tat'.tr()),
                        ],
                      ),
                    ),
                    height10(value: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          icon(
                              icon: Icons.notifications,
                              backgroundColor:
                                  const Color.fromRGBO(0, 200, 255, 1),
                              iconColor: Colors.white),
                          width10(),
                          title(title: 'thong_bao'.tr(), value: 'bật'),
                        ],
                      ),
                    ),
                    height10(value: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LanguageScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          icon(
                              icon: Icons.g_translate,
                              backgroundColor: Colors.red,
                              iconColor: Colors.white),
                          width10(),
                          title(
                              title: 'ngon_ngu'.tr(),
                              value: state.currentUser.language == Config.enCode
                                  ? 'tieng_anh'.tr()
                                  : 'tieng_viet'.tr()),
                        ],
                      ),
                    ),
                    myButton('Logout', () async {
                      await FirebaseAPI.signOut();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget icon(
        {required IconData icon,
        required Color backgroundColor,
        required Color iconColor}) =>
    Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(20)),
      child: Icon(
        icon,
        size: 20,
        color: iconColor,
      ),
    );

Widget title({required String title, required String value}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
