import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/setting/setting_bloc.dart';
import '../../configs/config.dart';
import '../../widgets/my_sizedbox.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);

    return BlocBuilder<SettingBloc, SettingState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('ngon_ngu'.tr()),
          ),
          body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ngon_ngu'.tr()),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .selectedItemColor!,
                            border: Border.all(
                              color: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .selectedItemColor!,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(15),
                          dropdownColor: Theme.of(context)
                              .bottomNavigationBarTheme
                              .selectedItemColor!,
                          value: state.language,
                          icon: const SizedBox(),
                          hint: Text(
                            'ngon_ngu'.tr(),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          underline: const SizedBox(),
                          onChanged: (value) {
                            if (value == 'en-US') {
                              context.setLocale(Config.english);
                              bloc.add(
                                  ChangeLanguage(languageCode: Config.enCode));
                            } else if (value == 'vi-VN') {
                              context.setLocale(Config.vietnamese);
                              bloc.add(
                                  ChangeLanguage(languageCode: Config.vnCode));
                            }
                          },
                          items: [
                            DropdownMenuItem(
                              alignment: Alignment.center,
                              value: 'en-US',
                              child: Text('tieng_anh'.tr(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            DropdownMenuItem(
                              alignment: Alignment.center,
                              value: 'vi-VN',
                              child: Text('tieng_viet'.tr(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height10(),
                  Text(
                    'thong_tin_ngon_ngu'.tr(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              )),
        );
      },
    );
  }
}
