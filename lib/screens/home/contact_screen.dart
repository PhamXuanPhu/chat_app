import 'package:chat_app/widgets/user_itemtemplate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/firebase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../models/chat.dart';
import '../chat/chat_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);
    FirebaseAPI.getContacts(bloc);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: BlocBuilder<UserBloc, UserState>(
          bloc: bloc,
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    Chat chat =
                        await FirebaseAPI.getChat(state.contacts[index]);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          chat: chat,
                        ),
                      ),
                    );
                  },
                  child: userItemTemplate(state.contacts[index]),
                );
              },
            );
          }),
    );
  }
}
