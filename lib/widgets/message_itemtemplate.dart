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
            ? const EdgeInsets.fromLTRB(100, 1, 15, 1)
            : const EdgeInsets.fromLTRB(15, 1, 100, 1),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
            color: message.from_id == CurrentUser.user.id
                ? colorMain
                : Theme.of(context).toggleableActiveColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          message.message,
          overflow: TextOverflow.visible,
          style: TextStyle(
              color: message.from_id == CurrentUser.user.id
                  ? Colors.white
                  : Theme.of(context).selectedRowColor),
        ),
      ),
    );
