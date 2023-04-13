// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/models/message.dart';
import 'package:chat_app/resources/colors.dart';
import 'package:flutter/material.dart';

import '../services/current_user_service.dart';

Widget messageItemTemplate(Message message, BuildContext context) => Align(
      alignment: message.from_id == CurrentUser.user.id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: message.from_id == CurrentUser.user.id
            ? const EdgeInsets.fromLTRB(100, 2, 2, 2)
            : const EdgeInsets.fromLTRB(2, 2, 100, 2),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: message.from_id == CurrentUser.user.id
                ? colorMain
                : Colors.grey.shade500,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          message.message,
          overflow: TextOverflow.visible,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
