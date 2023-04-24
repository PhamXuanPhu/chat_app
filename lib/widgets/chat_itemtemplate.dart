// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/widgets/avatar_template.dart';
import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../screens/chat/chat_screen.dart';
import '../services/from_to_service.dart';
import '../services/time_converter.dart';

Widget chatItemTemplate(Chat chat, BuildContext context) => InkWell(
      onTap: () {
        if (chat.id.isNotEmpty) {
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
        height: 65,
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Row(
          children: [
            avatarTemplate(
                url: toUser(chat.members).avatar,
                online: getStatus(chat.online!, toUser(chat.members).id)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(toUser(chat.members).name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Text(
                        timestampToDateTime(chat.update_on!),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    chat.last_message,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
