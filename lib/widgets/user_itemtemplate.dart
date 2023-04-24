// ignore_for_file: use_build_context_synchronously
import 'package:chat_app/models/user.dart';
import 'package:chat_app/widgets/avatar_template.dart';
import 'package:flutter/material.dart';

Widget userItemTemplate(User user) => Container(
      height: 65,
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Row(
        children: [
          avatarTemplate(url: user.avatar, online: user.online),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  user.email,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
