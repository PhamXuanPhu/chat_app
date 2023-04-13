// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../api/firebase.dart';
import '../models/chat.dart';
import '../screens/chat/chat_screen.dart';
import '../services/current_user_service.dart';
import '../services/global_key.dart';
import '../services/time_converter.dart';

Widget chatItemTemplate(Chat chat, BuildContext context) => InkWell(
      onTap: () {
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
        height: 65,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage(chat.to_avatar),
            ),
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
                        child: Text(
                            chat.to_id == CurrentUser.user.id
                                ? chat.from_name
                                : chat.to_name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
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
