// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:chat_app/services/validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../api/firebase.dart';
import '../../configs/config.dart';
import '../../services/loading_service.dart';
import '../../services/toast_service.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_filed.dart';
import '../../widgets/my_sizedbox.dart';
import '../login/login_screen.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  String oldpassword = "";
  String newpassword = "";
  String confirmpassword = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('doi_mat_khau'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              height10(),
              MyTextField(
                hintText: 'mat_khau_cu'.tr(),
                icon: Icons.lock_clock_outlined,
                onChanged: (value) {
                  oldpassword = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'noti_vui_long_nhap_mat_khau'.tr();
                  } else if (value != Config.password) {
                    return 'mat_khau_duoc_cung_cap_khong_dung'.tr();
                  }
                  return null;
                },
                text: oldpassword,
                isPassword: true,
              ),
              height10(),
              MyTextField(
                hintText: 'mat_khau_moi'.tr(),
                icon: Icons.lock_outline,
                onChanged: (value) {
                  newpassword = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'noti_vui_long_nhap_mat_khau'.tr();
                  }
                  if (!value.isValidPassword) {
                    return 'noti_mat_khau_duoc_cung_cap_qua_yeu'.tr();
                  }
                  return null;
                },
                text: newpassword,
                isPassword: true,
              ),
              height10(),
              MyTextField(
                hintText: 'xac_nhan_mat_khau'.tr(),
                icon: Icons.lock_open,
                onChanged: (value) {
                  confirmpassword = value;
                },
                validator: (value) {
                  if (newpassword != confirmpassword) {
                    return 'mat_khau_moi_va_mat_khau_xac_nhan_khong_khop'.tr();
                  }
                  return null;
                },
                text: confirmpassword,
                isPassword: true,
              ),
              height10(),
              myButton(
                'doi_mat_khau'.tr(),
                () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Loading.show(context);
                    String result =
                        await FirebaseAPI.changePassword(newpassword);
                    if (result.isEmpty) {
                      oldpassword = newpassword = confirmpassword = '';
                      await FirebaseAPI.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                      Toast.message(
                          context: context,
                          message: 'noti_thay_doi_mat_khau_thanh_cong'.tr());
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
