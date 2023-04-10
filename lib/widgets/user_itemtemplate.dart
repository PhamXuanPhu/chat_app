import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';

import '../services/global_key.dart';

Widget userItemTemplate(User user) => Container(
      height: 50,
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://img.hoidap247.com/picture/question/20200508/large_1588936738888.jpg'),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              user.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(GlobalVariable.navigatorKey.currentContext!)
                  .textTheme
                  .headlineMedium,
            ),
          )
        ],
      ),
    );
