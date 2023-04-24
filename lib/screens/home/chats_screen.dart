import 'package:chat_app/api/firebase.dart';
import 'package:flutter/material.dart';

import '../../models/chat.dart';
import '../../widgets/chat_itemtemplate.dart';

Widget chat() => Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: StreamBuilder(
          stream: FirebaseAPI.getChats(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Chat> chats = snapshot.data!.docs
                  .map((doc) => doc.data())
                  .toList()
                ..sort((a, b) => b.update_on!.compareTo(a.update_on!));

              return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return chatItemTemplate(chats[index], context);
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
