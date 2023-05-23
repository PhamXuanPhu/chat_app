import 'dart:async';

import 'package:chat_app/blocs/user/user_bloc.dart';
import 'package:chat_app/models/address.dart';
import 'package:chat_app/models/select_item.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/widgets/loading_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/gender.dart';
import '../../services/loading_service.dart';
import '../../services/toast_service.dart';
import '../../widgets/my_address_lookup.dart';
import '../../widgets/my_lookup.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_sizedbox.dart';
import '../../widgets/my_text_filed.dart';

class UpdateInfoUserSreen extends StatelessWidget {
  const UpdateInfoUserSreen({super.key});
  @override
  Widget build(BuildContext context) {
    late User user = User();
    final _formKey = GlobalKey<FormState>();
    SelectItem selectItem = SelectItem();
    Address address = Address();

    var bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(const LoadCurrentUser());

    return Scaffold(
        appBar: AppBar(
          title: Text('cap_nhat_thong_tin'.tr()),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is UserLoaded) {
              user = state.currentUser.copyWith();

              return Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height10(),
                        title('Email'),
                        MyTextField(
                          hintText: 'mat_khau_cu'.tr(),
                          onChanged: (value) {
                            user.email = value;
                          },
                          validator: (value) {
                            // if (value.isEmpty) {
                            //   return 'noti_vui_long_nhap_mat_khau'.tr();
                            // } else if (value != Config.password) {
                            //   return 'mat_khau_duoc_cung_cap_khong_dung'.tr();
                            // }
                            return null;
                          },
                          text: user.email,
                          readOnly: true,
                        ),
                        height10(),
                        title('Ten nguoi dung'),
                        MyTextField(
                          hintText: 'mat_khau_moi'.tr(),
                          onChanged: (value) {
                            user.name = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'noti_vui_long_nhap_mat_khau'.tr();
                            }
                            return null;
                          },
                          text: user.name,
                        ),
                        height10(),
                        title('ngay_sinh'.tr()),
                        MyLookup(
                          listItem: Gender.genders,
                          hintText: 'chon_ngay_sinh'.tr(),
                          selected: (value) {},
                        ),
                        height10(),
                        title('gioi_tinh'.tr()),
                        MyLookup(
                          listItem: Gender.genders,
                          hintText: 'chon_gioi_tinh'.tr(),
                          selected: (value) {
                            selectItem = value;
                          },
                        ),
                        title('dia_chi'.tr()),
                        MyAddressLookup(
                          hintText: 'chon_dia_chi'.tr(),
                          address: address,
                          submit: (value) {
                            address = value;
                          },
                        ),
                        myButton(
                          'cap_nhat_thong_tin'.tr(),
                          () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              Loading.show(context);
                              bloc.add(UpdateCurrentUser(newData: user));
                              Toast.message(
                                  context: context,
                                  message:
                                      'noti_thay_doi_mat_khau_thanh_cong'.tr());
                            } else {
                              Toast.message(
                                  context: context,
                                  message: 'loi_he_thong'.tr());
                            }
                            Loading.hide();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is UserLoading) {
              return loadingScreen();
            } else if (state is UserError) {
              return Container(
                color: Colors.amber,
              );
            } else {
              return Container(
                color: Colors.amber,
              );
            }
          },
        ));
  }

  Widget title(String text) => Container(
        padding: const EdgeInsets.all(5),
        child: Text(text),
      );
}
