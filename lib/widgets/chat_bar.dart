import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../resources/colors.dart';

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
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
              icon: const Icon(
                Icons.send_outlined,
                color: colorWhite,
              )),
        ),
      ]),
    );
  }

  SizedBox textField(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          decoration: InputDecoration(
              fillColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
              contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              hintText: 'nhap_tin_nhan'.tr(),
              filled: true,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!),
                  borderRadius: BorderRadius.circular(0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!),
                  borderRadius: BorderRadius.circular(0)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!),
                  borderRadius: BorderRadius.circular(0))),
          maxLines: 1,
        ),
      );
}
