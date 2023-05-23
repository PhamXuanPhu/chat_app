// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/models/user.dart';
import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:flutter/material.dart';

Widget addFriendItemTemplate(
        {required User user, required Function(bool) onPressed}) =>
    Container(
      height: 65,
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
            maxRadius: 25,
          ),
          width10(),
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
          ),
          width10(),
          button(
              text: 'Chap nhan',
              onPressed: () {
                onPressed(true);
              }),
          iconButton2(onPressed: () async {
            onPressed(false);
          }),
        ],
      ),
    );
Widget button({required String text, required VoidCallback onPressed}) =>
    TextButton(
        onPressed: onPressed,
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ));
Widget iconButton2({required VoidCallback onPressed}) => SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        icon: const Icon(Icons.close, size: 20),
        onPressed: onPressed,
        padding: const EdgeInsets.all(0),
        splashRadius: 10,
      ),
    );
