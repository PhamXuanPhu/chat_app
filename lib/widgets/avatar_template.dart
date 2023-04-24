import 'package:flutter/material.dart';

Widget avatarTemplate(
        {required String url, bool online = false, double radius = 25}) =>
    Stack(children: [
      CircleAvatar(
        maxRadius: radius,
        backgroundImage: NetworkImage(url),
      ),
      online
          ? Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.all(2),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
              ),
            )
          : const SizedBox.shrink()
    ]);
