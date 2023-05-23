import 'package:chat_app/services/loading_service.dart';
import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/setting/setting_bloc.dart';

class ActiveStatusScreen extends StatelessWidget {
  const ActiveStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('trang_thai_hoat_dong'.tr()),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('hien_thi_trang_thai_hoat_dong'.tr()),
              BlocBuilder<SettingBloc, SettingState>(
                bloc: bloc,
                builder: (context, state) {
                  return Switch(
                      value: state.activeStatus,
                      onChanged: (newvalue) {
                        Loading.show(context);
                        newvalue
                            ? bloc.add(
                                const SwitchActiveStatus(activeStatus: true))
                            : bloc.add(
                                const SwitchActiveStatus(activeStatus: false));
                        Loading.hide();
                      });
                },
              ),
            ]),
            height10(),
            Text(
              'thong_tin_hien_thi_trang_thai_hoat_dong'.tr(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
