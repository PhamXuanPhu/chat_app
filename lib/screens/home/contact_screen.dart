import 'package:chat_app/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/user_itemtemplate.dart';

Widget contact() => BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return FutureBuilder(
        future: load(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return userItemTemplate(state.users[index]);

                // return itemTemplate(list[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          } else {
            return Container();
          }
        },
      );
    });

Future<bool> load(BuildContext context) async {
  context.read<UserBloc>().add(const LoadUsers());
  return true;
}
