import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/resources/colors.dart';
import 'package:chat_app/services/data_service.dart';
import 'package:chat_app/widgets/chat_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../api/firebase.dart';
import '../../configs/config.dart';
import '../../services/current_user_service.dart';
import '../../widgets/button_custom.dart';
import '../../widgets/messageItemtemplate.dart';
import '../../widgets/text_filed_custom.dart';

class ChatScreen extends StatelessWidget {
  static const id = 'chat_screen';
  final Chat chat;

  ChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - 75 - AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          chat.from_id == CurrentUser.user.id ? chat.to_name : chat.from_name,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height,
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
                            return messageItemTemplate(
                                messages[index], context);
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
            ChatBar(onChanged: (message) async {
              if (message.isNotEmpty) {
                Message mess = Message(
                    id: DateTime.now().toString(),
                    chat_id: chat.id,
                    from_id: CurrentUser.user.id,
                    message: message,
                    update_on: Timestamp.now(),
                    to_id: chat.to_id == CurrentUser.user.id
                        ? chat.from_id
                        : chat.to_id,
                    show: true);
                await FirebaseAPI.sendMessage(mess);
              }
            }),
          ],
        ),
      ),
    );
  }
}
