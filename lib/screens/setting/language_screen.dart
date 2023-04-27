import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/setting/setting_bloc.dart';
import '../../configs/config.dart';
import '../../services/data_service.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ngon_ngu'.tr()),
      ),
      body: Container(
        child: Row(
          children: [
            Text('ngon_ngu'.tr()),
            BlocBuilder<SettingBloc, SettingState>(
              bloc: bloc,
              builder: (context, state) {
                return dropdownButton(context: context, bloc: bloc);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownButton(
          {required BuildContext context, required SettingBloc bloc}) =>
      Container(
          height: 35,
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor!,
              ),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
          child: BlocBuilder<SettingBloc, SettingState>(
            bloc: bloc,
            builder: (context, state) {
              return DropdownButton(
                icon: SizedBox(),
                hint: Text(
                  'ngon_ngu'.tr(),
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).selectedRowColor),
                ),
                underline: SizedBox(),
                onChanged: (value) {
                  if (value == 'en') {
                    context.setLocale(Config.english);
                    bloc.add(ChangeLanguage(languageCode: Config.enCode));
                  } else if (value == 'vi') {
                    context.setLocale(Config.vietnamese);
                    bloc.add(ChangeLanguage(languageCode: Config.vnCode));
                  }
                },
                items: [
                  DropdownMenuItem(
                    alignment: Alignment.center,
                    value: 'en',
                    child:
                        Text('tieng_anh'.tr(), style: TextStyle(fontSize: 16)),
                  ),
                  DropdownMenuItem(
                    alignment: Alignment.center,
                    value: 'vi',
                    child:
                        Text('tieng_viet'.tr(), style: TextStyle(fontSize: 16)),
                  ),
                ],
              );
            },
          ));
}
