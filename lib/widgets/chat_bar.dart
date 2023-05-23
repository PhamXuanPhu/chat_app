// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChatBar extends StatefulWidget {
  final Function(String) onChanged;

  const ChatBar({super.key, required this.onChanged});

  @override
  State<ChatBar> createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).bottomAppBarColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      // color: Theme.of(context).bottomAppBarColor,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        textField(context),
        SizedBox(
          height: 35,
          width: 35,
          child: IconButton(
              onPressed: () {
                widget.onChanged(controller.text);
                controller.text = '';
              },
              padding: const EdgeInsets.all(0),
              icon: Icon(
                Icons.send,
                size: 22,
                color: Theme.of(context).selectedRowColor,
              )),
        ),
      ]),
    );
  }

  SizedBox textField(BuildContext context) => SizedBox(
        height: 35,
        width: MediaQuery.of(context).size.width - 50,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          keyboardType: TextInputType.multiline,
          style: TextStyle(
              fontSize: 15, color: Theme.of(context).selectedRowColor),
          decoration: InputDecoration(
              fillColor: Theme.of(context).toggleableActiveColor,
              contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              hintText: 'nhap_tin_nhan'.tr(),
              filled: true,
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    color: Theme.of(context).toggleableActiveColor,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    color: Theme.of(context).toggleableActiveColor,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    color: Theme.of(context).toggleableActiveColor,
                  ),
                  borderRadius: BorderRadius.circular(20))),
          maxLines: null,
          textInputAction: TextInputAction.newline,
        ),
      );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
