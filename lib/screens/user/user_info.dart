// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:chat_app/widgets/loading_screen.dart';
import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/firebase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../services/loading_service.dart';
import '../../services/toast_service.dart';
import '../../widgets/my_button.dart';

class UserInfo extends StatelessWidget {
  final String userID;
  const UserInfo({super.key, required this.userID});

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
            return Center(
              child: Column(
                children: [
                  height10(value: 20),
                  CircleAvatar(
                    backgroundImage: NetworkImage(state.user.avatar),
                    maxRadius: 45,
                  ),
                  height10(value: 15),
                  Text(
                    state.user.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  height10(value: 15),
                  Container(
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
                      onPressed: () {},
                      padding: const EdgeInsets.all(0),
                      splashRadius: 10,
                    ),
                  ),
                  Text(state.user.email),
                  Text(state.user.avatar),
                  myButton('Add Friend', () async {
                    Loading.show(context);
                    bool addFriend =
                        await FirebaseAPI.sendRequest(state.user.id);
                    if (addFriend) {
                      Toast.message(
                          context: context,
                          message: 'noti_da_gui_loi_moi_ket_ban'.tr());
                    } else {
                      Toast.message(
                          context: context, message: 'noti_loi_he_thong'.tr());
                    }
                    Loading.hide();
                  }),
                ],
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
}
