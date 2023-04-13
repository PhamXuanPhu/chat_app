import 'package:chat_app/configs/config.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/firebase.dart';
import '../../blocs/switch/switch_bloc.dart';
import '../../services/global_key.dart';
import '../../services/data_service.dart';
import '../../widgets/button_custom.dart';

const Locale swissFrench = Locale('fr', 'CH');

Widget user() => Container(
      child: Column(
        children: [
          buttonCustom('Tiếng Anh', () async {
            GlobalVariable.navigatorKey.currentContext!
                .setLocale(Config.english);
            DataService.setLanguage(Config.enCode);
          }),
          buttonCustom2('Tiếng Việt', () async {
            GlobalVariable.navigatorKey.currentContext!
                .setLocale(Config.vietnamese);
            DataService.setLanguage(Config.vnCode);
          }),
          BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return Switch(
                  value: state.switchValue,
                  onChanged: ((newValue) {
                    context
                        .read<SwitchBloc>()
                        .add(SwitchEvent(switchValue: newValue));
                  }));
            },
          ),
          buttonCustom2('Loginout', () async {
            await FirebaseAPI.signOut();
            Navigator.pushReplacement(
              GlobalVariable.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }),
          buttonCustom2('send', () async {
            Message message = Message(
                id: "1264511",
                chat_id:
                    'Cdx9pA1qtdRwXUvORAb930UDoMw19TvWV9S40Ie5jWpGC1iOGvuPYsH3',
                from_id: 'Cdx9pA1qtdRwXUvORAb930UDoMw1',
                message: DateTime.now().toString(),
                update_on: Timestamp.now(),
                to_id: '9TvWV9S40Ie5jWpGC1iOGvuPYsH3',
                show: true);
            await FirebaseAPI.sendMessage(message);
          }),
        ],
      ),
    );
