import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/setting/setting_bloc.dart';
import '../../widgets/radio_custom.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('che_do'.tr()),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.red,
                  height: 300,
                  width: 100,
                ),
                Container(
                  color: Colors.yellow,
                  height: 300,
                  width: 100,
                )
              ],
            ),
            height10(value: 20),
            BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                return RadioCustom(
                  selected: state.theme ? 1 : 0,
                  onPressed: (selected) {
                    selected == 0
                        ? bloc.add(const SwitchThemeApp(theme: false))
                        : bloc.add(const SwitchThemeApp(theme: true));
                  },
                  children: const [
                    MyRadioButton(
                      iconData: Icons.light_mode,
                      width: 75,
                      height: 35,
                    ),
                    MyRadioButton(
                      iconData: Icons.dark_mode,
                      width: 75,
                      height: 35,
                    )
                  ],
                );
              },
            ),
            height10(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'thong_tin_che_do_hien_thi'.tr(),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
