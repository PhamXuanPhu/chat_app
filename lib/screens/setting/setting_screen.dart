// ignore_for_file: deprecated_member_use

import 'package:chat_app/screens/user/change_password_screen.dart';
import 'package:chat_app/screens/setting/language_screen.dart';
import 'package:chat_app/screens/setting/mode_screen.dart';
import 'package:chat_app/screens/setting/notification_screen.dart';
import 'package:chat_app/screens/setting/active_status_screen.dart';
import 'package:chat_app/screens/user/delete_account.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/setting/setting_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/my_sizedbox.dart';
import '../user/update_info_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder<UserBloc, UserState>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('thiet_lap'.tr()),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height10(value: 20),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(state.currentUser.avatar),
                          maxRadius: 45,
                        ),
                        height10(),
                        Text(
                          state.currentUser.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  height10(value: 15),
                  groupItem(text: 'thiet_lap'.tr()),
                  item(
                    icon: Icons.dark_mode,
                    backgroundColor: Theme.of(context).toggleableActiveColor,
                    iconColor: Theme.of(context).selectedRowColor,
                    text: 'che_do'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ModeScreen()),
                      );
                    },
                  ),
                  item(
                    icon: Icons.radio_button_on,
                    backgroundColor: const Color.fromRGBO(69, 213, 90, 1),
                    iconColor: Colors.white,
                    text: 'trang_thai_hoat_dong'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ActiveStatusScreen()),
                      );
                    },
                  ),
                  item(
                    icon: Icons.notifications,
                    backgroundColor: const Color.fromRGBO(0, 200, 255, 1),
                    iconColor: Colors.white,
                    text: 'thong_bao'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                  ),
                  item(
                    icon: Icons.translate,
                    backgroundColor: Colors.red,
                    iconColor: Colors.white,
                    iconSize: 15,
                    text: 'ngon_ngu'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LanguageScreen()),
                      );
                    },
                  ),
                  height10(),
                  groupItem(text: 'tai_khoan'.tr()),
                  item(
                    icon: Icons.lock_outline,
                    backgroundColor: Theme.of(context).toggleableActiveColor,
                    iconColor: Theme.of(context).selectedRowColor,
                    text: 'doi_mat_khau'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen()),
                      );
                    },
                  ),
                  item(
                    icon: Icons.manage_accounts_outlined,
                    backgroundColor: const Color.fromRGBO(69, 213, 90, 1),
                    iconColor: Colors.white,
                    text: 'cap_nhat_thong_tin'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateInfoUserSreen()),
                      );
                    },
                  ),
                  item(
                    icon: Icons.block_outlined,
                    backgroundColor: Colors.red,
                    iconColor: Colors.white,
                    iconSize: 15,
                    text: 'xoa_tai_khoan'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteAccountScreen()),
                      );
                    },
                  ),
                  height10(),
                  groupItem(text: 'lien_he'.tr()),
                  item(
                    icon: Icons.report,
                    backgroundColor: Theme.of(context).toggleableActiveColor,
                    iconColor: Theme.of(context).selectedRowColor,
                    text: 'bao_loi'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ModeScreen()),
                      );
                    },
                  ),
                  item(
                    icon: Icons.help,
                    backgroundColor: const Color.fromRGBO(69, 213, 90, 1),
                    iconColor: Colors.white,
                    text: 'yeu_cau_ho_tro'.tr(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ModeScreen()),
                      );
                    },
                  ),
                  height10(value: 20)
                ],
              ),
            ),
          );
        });
  }

  Widget groupItem({required String text}) => Container(
        margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );

  Widget item(
          {required IconData icon,
          required Color backgroundColor,
          required Color iconColor,
          double iconSize = 20,
          required String text,
          required VoidCallback onPressed}) =>
      InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
              width10(),
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      );
}
