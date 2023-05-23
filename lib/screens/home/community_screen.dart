import 'package:chat_app/widgets/user_itemtemplate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/firebase.dart';
import '../../blocs/user/user_bloc.dart';
import '../user/user_info.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);
    FirebaseAPI.getUsers(bloc);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: BlocBuilder<UserBloc, UserState>(
          bloc: bloc,
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async {
                      // bloc.add(LoadUser(userID: state.users[index].id));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserInfo(userID: state.users[index].id),
                        ),
                      );
                    },
                    child: userItemTemplate(state.users[index]));
              },
            );
          }),
    );
  }
}
