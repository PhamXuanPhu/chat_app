import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ActiveStatusScreen extends StatelessWidget {
  const ActiveStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool value = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('trang_thai_hoat_dong'.tr()),
      ),
      body: Container(
        child: Column(children: [
          Text('trang_thai_hoat_dong'.tr()),
          Switch(value: value, onChanged: (newvalue) {})
        ]),
      ),
    );
  }
}
