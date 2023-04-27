import 'package:chat_app/blocs/setting/setting_bloc.dart';
import 'package:chat_app/services/current_user_service.dart';
import 'package:chat_app/widgets/avatar_template.dart';
import 'package:chat_app/widgets/icon_button.dart';
import 'package:chat_app/widgets/sizedbox_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/firebase.dart';
import '../blocs/user/user_bloc.dart';
import '../configs/config.dart';
import '../screens/login/login_screen.dart';
import '../screens/setting/setting_screen.dart';
import '../services/data_service.dart';
import '../services/global_key.dart';
import 'button_custom.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final blocSetting = BlocProvider.of<SettingBloc>(context);
    final blocUser = BlocProvider.of<UserBloc>(context);
    FirebaseAPI.listenUser(blocUser, CurrentUser.user.id);
    final language = getLanguage();

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<SettingBloc, SettingState>(
            bloc: blocSetting,
            builder: (context, state) {
              return Column(
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    bloc: blocUser,
                    builder: (context, state) {
                      return Row(
                        children: [
                          SizedBox(
                              height: 35,
                              width: 35,
                              child: avatarTemplate(url: state.user.avatar)),
                          width10(),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  state.user.name,
                                  style: const TextStyle(fontSize: 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                DropdownButton(items: [
                                  DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: '1',
                                    child: Container(
                                        padding: EdgeInsets.all(0),
                                        child: Text('logout')),
                                  ),
                                ], onChanged: (value) {})
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
                      );
                    },
                  ),
                  height10(value: 20),
                  Row(
                    children: [
                      icon(
                        icon: Icons.dark_mode,
                        backgroundColor:
                            Theme.of(context).toggleableActiveColor,
                        iconColor: Theme.of(context).selectedRowColor,
                      ),
                      width10(),
                      title(title: 'che_do'.tr(), value: 'sáng'),
                    ],
                  ),
                  height10(value: 20),
                  Row(
                    children: [
                      icon(
                          icon: Icons.radio_button_on,
                          backgroundColor: const Color.fromRGBO(69, 213, 90, 1),
                          iconColor: Colors.white),
                      width10(),
                      title(title: 'trang_thai'.tr(), value: 'bật'),
                    ],
                  ),
                  height10(value: 20),
                  Row(
                    children: [
                      icon(
                          icon: Icons.notifications,
                          backgroundColor: Color.fromRGBO(0, 200, 255, 1),
                          iconColor: Colors.white),
                      width10(),
                      title(title: 'thong_bao'.tr(), value: 'bật'),
                    ],
                  ),
                  height10(value: 20),
                  Row(
                    children: [
                      icon(
                          icon: Icons.g_translate,
                          backgroundColor: Colors.red,
                          iconColor: Colors.white),
                      width10(),
                      title(
                          title: 'ngon_ngu'.tr(),
                          value: language == Config.enCode
                              ? 'tieng_anh'.tr()
                              : 'tieng_viet'.tr()),
                    ],
                  ),
                  buttonCustom('Logout', () async {
                    await FirebaseAPI.signOut();
                    Navigator.pushReplacement(
                      GlobalVariable.navigatorKey.currentContext!,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  })
                ],
              );
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

Future<String> getLanguage() async {
  var language = await DataService.getLanguage();
  return language;
}
