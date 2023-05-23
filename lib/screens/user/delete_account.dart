// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../api/firebase.dart';
import '../../configs/config.dart';
import '../../helper/data_helper.dart';
import '../../services/loading_service.dart';
import '../../services/toast_service.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_filed.dart';
import '../../widgets/my_sizedbox.dart';
import '../login/login_screen.dart';

// ignore: must_be_immutable
class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});
  String password = "";
  String username = "";
  final _formKey = GlobalKey<FormState>();

  Future<String> getPassword() async {
    var b = await DataHelper().getData(Config.keyPassword);
    return b;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('xoa_tai_khoan'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height10(),
              Text(
                'xac_nhan_xoa_tai_khoan'.tr(),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              height10(),
              MyTextField(
                icon: Icons.person_outline,
                hintText: 'ten_nguoi_dung'.tr(),
                onChanged: (value) {
                  username = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'noti_vui_long_nhap_ten_nguoi_dung'.tr();
                  } else if (value != Config.user.name) {
                    return 'ten_nguoi_dung_khong_dung'.tr();
                  }
                  return null;
                },
              ),
              height10(),
              MyTextField(
                icon: Icons.lock_outline,
                hintText: 'mat_khau'.tr(),
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'noti_vui_long_nhap_mat_khau'.tr();
                  } else if (value != Config.password) {
                    return 'mat_khau_duoc_cung_cap_khong_dung'.tr();
                  }
                  return null;
                },
                isPassword: true,
              ),
              height10(),
              myButton(
                'xoa_tai_khoan'.tr(),
                () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Loading.show(context);
                    String result = await FirebaseAPI.deleteAccount();
                    if (result.isEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                      Toast.message(
                          context: context,
                          message: 'noti_da_xoa_tai_khoan'.tr());
                    } else {
                      Toast.message(context: context, message: result);
                    }
                    Loading.hide();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
