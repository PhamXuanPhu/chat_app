import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('che_do'.tr()),
      ),
      body: Container(
        height: 400,
        width: 400,
        color: Colors.red,
        child: Stack(children: [
          SafeArea(
            child: Container(
              color: Colors.yellow,
            ),
          ),
        ]),
      ),
    );
  }
}
