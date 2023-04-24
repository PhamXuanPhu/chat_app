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
import '../screens/login_screen.dart';
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

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              //   color: Theme.of(context).appBarTheme.backgroundColor,
              //   child: Center(
              //     child: Text(
              //       'thong_tin_nguoi_dung'.tr(),
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400,
              //         color: Theme.of(context).appBarTheme.foregroundColor,
              //       ),
              //     ),
              //   ),
              // ),
              BlocBuilder<UserBloc, UserState>(
                bloc: blocUser,
                builder: (context, state) {
                  return Row(
                    children: [
                      avatarTemplate(url: state.user.avatar, radius: 20),
                      width10(),
                      Expanded(
                        child: Text(
                          state.user.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      iconButton(
                          context: context,
                          icon: Icons.settings,
                          onPressed: () {}),
                    ],
                  );
                },
              ),
              height10(value: 20),
              Row(
                children: [
                  icon(Icons.pending),
                  width10(),
                  title(title: 'Chế độ', value: 'sáng'),
                ],
              ),
              height10(value: 20),
              Row(
                children: [
                  icon(Icons.pending),
                  width10(),
                  title(title: 'Ngôn ngữ', value: 'Tiếng anh'),
                ],
              ),
              height10(value: 20),
              Row(
                children: [
                  icon(Icons.pending),
                  width10(),
                  title(title: 'data', value: 'data'),
                ],
              ),
              BlocBuilder<SettingBloc, SettingState>(
                bloc: blocSetting,
                builder: (context, state) {
                  return buttonCustom('Tiếng Anh', () async {
                    context.setLocale(Config.english);
                    DataService.setLanguage(Config.enCode);
                    blocSetting.add(const ReloadLanguage());
                  });
                },
              ),
              BlocBuilder<SettingBloc, SettingState>(
                bloc: blocSetting,
                builder: (context, state) {
                  return buttonCustom2('Tiếng Việt', () async {
                    context.setLocale(Config.vietnamese);
                    DataService.setLanguage(Config.vnCode);
                    blocSetting.add(const ReloadLanguage());
                  });
                },
              ),
              BlocBuilder<SettingBloc, SettingState>(
                bloc: blocSetting,
                builder: (context, state) {
                  return Switch(
                      value: state.theme,
                      onChanged: ((newValue) {
                        blocSetting.add(SwitchThemeApp(switchValue: newValue));
                      }));
                },
              ),
              buttonCustom2('Loginout', () async {
                await FirebaseAPI.signOut();
                Navigator.pushReplacement(
                  GlobalVariable.navigatorKey.currentContext!,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }),
              // GestureDetector(
              //   onTap: () =>
              //       Navigator.of(context).pushReplacementNamed(CustomerScreen.id),
              //   child: const ListTile(
              //     leading: Icon(Icons.delete),
              //     title: Text('Customer'),
              //     trailing: Text('0'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget icon(IconData icon) => Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
      child: Icon(
        icon,
        size: 20,
        color: Colors.blue,
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
            fontSize: 15,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
