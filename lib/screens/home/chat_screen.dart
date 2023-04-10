import 'package:chat_app/api/firebase.dart';
import 'package:flutter/material.dart';

import '../../models/chat.dart';
import '../../widgets/chat_itemtemplate.dart';

Widget chat() => StreamBuilder(
    stream: FirebaseAPI.getChats(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Chat> chats =
            snapshot.data!.docs.map((doc) => doc.data()).toList();
        return ListView.separated(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return chatItemTemplate(chats[index]);

            // return itemTemplate(list[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
