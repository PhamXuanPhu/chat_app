import 'package:chat_app/screens/setting/language_screen.dart';
import 'package:chat_app/screens/setting/mode_screen.dart';
import 'package:chat_app/screens/setting/notification_screen.dart';
import 'package:chat_app/screens/setting/status_screen.dart';
import 'package:chat_app/screens/user/change_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/firebase.dart';
import '../../blocs/setting/setting_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../configs/config.dart';
import '../../services/data_service.dart';
import '../../widgets/sizedbox_custom.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('title_chat'.tr()),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocBuilder<SettingBloc, SettingState>(
            bloc: bloc,
            builder: (context, state) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height10(value: 20),
                    Center(child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(state.user.avatar),
                              maxRadius: 45,
                            ),
                            height10(),
                            Text(
                              state.user.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        );
                      },
                    )),
                    height10(value: 15),
                    groupItem(text: 'Thiết lập'),
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
                    groupItem(text: 'Tài khoản'),
                    item(
                      icon: Icons.dark_mode,
                      backgroundColor: Theme.of(context).toggleableActiveColor,
                      iconColor: Theme.of(context).selectedRowColor,
                      text: 'Đổi mật khẩu',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordSreen()),
                        );
                      },
                    ),
                    item(
                      icon: Icons.radio_button_on,
                      backgroundColor: const Color.fromRGBO(69, 213, 90, 1),
                      iconColor: Colors.white,
                      text: 'Đổi thông tin',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ModeScreen()),
                        );
                      },
                    ),
                    item(
                      icon: Icons.translate,
                      backgroundColor: Colors.red,
                      iconColor: Colors.white,
                      iconSize: 15,
                      text: 'Khóa tài khoản',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ModeScreen()),
                        );
                      },
                    ),
                    height10(),
                    groupItem(text: 'Liên hệ'),
                    item(
                      icon: Icons.dark_mode,
                      backgroundColor: Theme.of(context).toggleableActiveColor,
                      iconColor: Theme.of(context).selectedRowColor,
                      text: 'Báo lỗi',
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
                      text: 'Yêu cầu hỗ trợ',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ModeScreen()),
                        );
                      },
                    ),
                    height10(value: 20)
                  ]);
            },
          ),
        ),
      ),
    );
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
