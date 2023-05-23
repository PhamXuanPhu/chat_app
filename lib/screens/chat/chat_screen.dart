import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/guid_generate.dart';
import 'package:chat_app/widgets/chat_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/firebase.dart';
import '../../blocs/user/user_bloc.dart';
import '../../configs/config.dart';
import '../../services/from_to_service.dart';
import '../../widgets/avatar_template.dart';
import '../../widgets/message_itemtemplate.dart';
import '../../widgets/my_sizedbox.dart';

class ChatScreen extends StatelessWidget {
  static const id = 'chat_screen';
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    //get user
    User to = toUser(chat.members);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30.0,
        title: StreamBuilder(
          stream: FirebaseAPI.streamOnline(to.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userTo = snapshot.data!.data();
              return Row(
                children: [
                  avatarTemplate(
                      url: userTo!.avatar, online: userTo.online, radius: 18),
                  width10(value: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userTo.name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          userTo.online
                              ? 'truc_tuyen'.tr()
                              : 'ngoai_tuyen'.tr(),
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: const Icon(Icons.info),
                    onTap: () {},
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseAPI.getMessages(chat.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Message> messages =
                        snapshot.data!.docs.map((doc) => doc.data()).toList();
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return messageItemTemplate(messages[index], context);
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 60,
            child: ChatBar(onChanged: (message) async {
              if (message.isNotEmpty) {
                Message mess = Message(
                    id: GUID.generate(),
                    chat_id: chat.id,
                    from_id: Config.user.id,
                    message: message,
                    update_on: Timestamp.now(),
                    to_id: to.id,
                    show: true);
                await FirebaseAPI.sendMessage(mess);
              }
            }),
          ),
        ],
      ),
    );
  }
}
