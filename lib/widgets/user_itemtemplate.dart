// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/global_key.dart';

Widget userItemTemplate(User user, BuildContext context) => InkWell(
      onTap: () async {
        Chat chat = await FirebaseAPI.getChat(user);
        if (chat.to_id.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                chat: chat,
              ),
            ),
          );
        } else {}
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://img.hoidap247.com/picture/question/20200508/large_1588936738888.jpg'),
              maxRadius: 25,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
