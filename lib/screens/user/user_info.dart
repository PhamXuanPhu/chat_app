// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:chat_app/resources/gender.dart';
import 'package:chat_app/widgets/loading_screen.dart';
import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/firebase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../services/loading_service.dart';
import '../../services/toast_service.dart';

class UserInfo extends StatelessWidget {
  final String userID;
  final bool? fromChat;
  const UserInfo({super.key, required this.userID, this.fromChat = false});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(LoadUser(userID: userID));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leadingWidth: 30.0,
        title: const SizedBox.shrink(),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is UserLoaded) {
            String birthday = '';
            DateTime? birthday_value = DateTime.tryParse(state.user.birthday);
            if (birthday_value != null) {
              birthday = DateFormat('dd-MM-yyyy').format(birthday_value);
            }
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(state.user.avatar),
                            maxRadius: 50,
                          ),
                          height10(value: 20),
                          Text(
                            state.user.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          height10(value: 5),
                          fromChat != null && fromChat!
                              ? height10(value: 35)
                              : iconButton(
                                  onPressed: () async {
                                    Loading.show(context);
                                    bool addFriend =
                                        await FirebaseAPI.sendRequest(
                                            state.user.id);
                                    if (addFriend) {
                                      Toast.message(
                                          context: context,
                                          message: 'noti_da_gui_loi_moi_ket_ban'
                                              .tr());
                                    } else {
                                      Toast.message(
                                          context: context,
                                          message: 'noti_loi_he_thong'.tr());
                                    }
                                    Loading.hide();
                                  },
                                ),
                        ],
                      ),
                    ),
                    height10(),
                    group(text: 'lien_he'.tr()),
                    field(title: 'email'.tr(), text: state.user.email),
                    line(),
                    field(title: 'so_dien_thoai'.tr(), text: state.user.phone),
                    line(),
                    height10(),
                    group(text: 'thong_tin'.tr()),
                    field(
                        title: 'gioi_tinh'.tr(),
                        text: Gender.getGenderWithID(state.user.gender) != null
                            ? Gender.getGenderWithID(state.user.gender)!.name
                            : ''),
                    line(),
                    field(title: 'ngay_sinh'.tr(), text: birthday),
                    line(),
                    height10(),
                    group(text: 'dia_chi'.tr()),
                    field(
                        title: 'quoc_gia'.tr(), text: state.user.country_name),
                    line(),
                    field(
                        title: 'tinh_thanh'.tr(),
                        text: state.user.province_name),
                    line(),
                    field(
                        title: 'quan_huyen'.tr(),
                        text: state.user.district_name),
                    line(),
                    field(title: 'xa_phuong'.tr(), text: state.user.ward_name),
                    line(),
                    field(title: 'xa_phuong'.tr(), text: state.user.street),
                    line(),
                    field(title: 'dia_chi'.tr(), text: state.user.address),
                  ],
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
      ),
    );
  }

  Widget iconButton({required Function() onPressed}) =>
      Builder(builder: (context) {
        return Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Theme.of(context).toggleableActiveColor,
              borderRadius: BorderRadius.circular(20)),
          child: IconButton(
            icon: Icon(
              Icons.person_add,
              size: 20,
              color: Theme.of(context).selectedRowColor,
            ),
            onPressed: onPressed,
            padding: const EdgeInsets.all(0),
            splashRadius: 10,
          ),
        );
      });

  Widget line() => Builder(builder: (context) {
        return Divider(
          color: Theme.of(context).selectedRowColor,
        );
      });

  Widget group({required String text}) => Container(
        margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );

  Widget field({required String title, required String text}) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 15, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(title),
            ),
            Expanded(
                flex: 2,
                child: Text(
                  text,
                  textAlign: TextAlign.right,
                ))
          ],
        ),
      );
}
