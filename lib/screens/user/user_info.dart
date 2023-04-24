import 'package:chat_app/widgets/sizedbox_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/firebase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../services/loading_service.dart';
import '../../services/toast_service.dart';
import '../../widgets/button_custom.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leadingWidth: 30.0,
        title: SizedBox.shrink(),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: bloc,
        builder: (context, state) {
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
                buttonCustom('Add Friend', () async {
                  Loading().show();
                  bool addFriend = await FirebaseAPI.sendRequest(state.user.id);
                  if (addFriend) {
                    Toast.success('noti_da_gui_loi_moi_ket_ban'.tr());
                  } else {
                    Toast.success('noti_loi_he_thong'.tr());
                  }
                  Loading().hide();
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
