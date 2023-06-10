import 'dart:async';
import 'dart:io';
import 'package:chat_app/blocs/user/user_bloc.dart';
import 'package:chat_app/models/address.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/user/change_avatar_screen.dart';
import 'package:chat_app/services/validator.dart';
import 'package:chat_app/widgets/loading_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/gender.dart';
import '../../services/loading_service.dart';
import '../../services/toast_service.dart';
import '../../widgets/my_address_lookup.dart';
import '../../widgets/my_datetime_picker.dart';
import '../../widgets/my_lookup.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_sizedbox.dart';
import '../../widgets/my_text_filed.dart';

class UpdateInfoUserSreen extends StatelessWidget {
  const UpdateInfoUserSreen({super.key});
  @override
  Widget build(BuildContext context) {
    User user = User();
    final _formKey = GlobalKey<FormState>();

    var bloc = BlocProvider.of<UserBloc>(context);
    if (bloc.state.currentUser.id.isEmpty) {
      bloc.add(const LoadCurrentUser());
    }

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
                        Center(
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  user.avatar,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .toggleableActiveColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Theme.of(context).selectedRowColor,
                                    ),
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChangeAvatarScreen()),
                                      );
                                    },
                                    padding: const EdgeInsets.all(0),
                                    splashRadius: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        height10(),
                        title('Email'),
                        MyTextField(
                          hintText: 'email'.tr(),
                          onChanged: (value) {
                            user.email = value;
                          },
                          text: user.email,
                          readOnly: true,
                        ),
                        height10(),
                        title('ten_nguoi_dung'.tr()),
                        MyTextField(
                          hintText: 'ten_nguoi_dung'.tr(),
                          onChanged: (value) {
                            user.name = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'noti_vui_long_nhap_ten_nguoi_dung'.tr();
                            }
                            return null;
                          },
                          text: user.name,
                        ),
                        height10(),
                        title('so_dien_thoai'.tr()),
                        MyTextField(
                          hintText: 'so_dien_thoai'.tr(),
                          onChanged: (value) {
                            user.phone = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'noti_vui_long_nhap_so_dien_thoai'.tr();
                            } else if (!value.isValidPhoneNumber) {
                              return 'noti_vui_long_nhap_so_dien_thoai_hop_le'
                                  .tr();
                            }
                            return null;
                          },
                          text: user.phone,
                        ),
                        height10(),
                        title('ngay_sinh'.tr()),
                        MyDatetimePicker(
                          hintText: 'chon_ngay_sinh'.tr(),
                          datetime: DateTime.tryParse(user.birthday),
                          selected: (value) {
                            user.birthday = value.toString();
                          },
                        ),
                        height10(),
                        title('gioi_tinh'.tr()),
                        MyLookup(
                          listItem: Gender.genders,
                          hintText: 'chon_gioi_tinh'.tr(),
                          selectItem: Gender.getGenderWithID(user.gender),
                          selected: (value) {
                            user.gender = value.id;
                          },
                        ),
                        height10(),
                        title('dia_chi'.tr()),
                        MyAddressLookup(
                          hintText: 'chon_dia_chi'.tr(),
                          address: Address(
                              countryId: user.country_id,
                              countryName: user.country_name,
                              provinceId: user.province_id,
                              provinceName: user.province_name,
                              districtId: user.district_id,
                              districtName: user.district_name,
                              wardId: user.ward_id,
                              wardName: user.ward_name,
                              street: user.street,
                              address: user.address),
                          submit: (value) {
                            user.country_id = value.countryId;
                            user.country_name = value.countryName;
                            user.province_id = value.provinceId;
                            user.province_name = value.provinceName;
                            user.district_id = value.districtId;
                            user.district_name = value.districtName;
                            user.ward_id = value.wardId;
                            user.ward_name = value.wardName;
                            user.address = value.address;
                            user.street = value.street;
                          },
                        ),
                        height10(value: 20),
                        myButton(
                          'cap_nhat_thong_tin'.tr(),
                          () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              Loading.show(context);
                              bloc.add(UpdateCurrentUser(newData: user));
                              Toast.message(
                                  context: context,
                                  message: 'noti_thay_doi_thong_tin_thanh_cong'
                                      .tr());
                              Loading.hide();
                            }
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
              return Container();
            } else {
              return Container();
            }
          },
        ));
  }

  Widget title(String text) => Container(
        padding: const EdgeInsets.all(5),
        child: Text(text),
      );
}
