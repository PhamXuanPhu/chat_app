import 'package:chat_app/services/validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../resources/colors.dart';

class TextFiledUserName extends StatefulWidget {
  const TextFiledUserName(
      {Key? key, required this.hintText, required this.onChanged, this.text})
      : super(key: key);

  final String hintText;
  final Function(String) onChanged;
  final String? text;
  @override
  State<TextFiledUserName> createState() => _TextFiledUserNameState();
}

class _TextFiledUserNameState extends State<TextFiledUserName> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
    if (widget.text != null && widget.text!.isNotEmpty) {
      controller.text = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => {widget.onChanged(value)},
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'noti_vui_long_nhap_ten_nguoi_dung'.tr();
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontSize: 15,
        color: colorWhite,
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: widget.hintText,
          prefixIcon: const Icon(
            Icons.perm_identity_outlined,
            color: colorWhite,
            size: 20,
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () => {controller.clear()},
                  icon: const Icon(
                    Icons.clear_outlined,
                    color: colorWhite,
                    size: 20,
                  ),
                ),

          ///fillColor, filled thay đổi màu background textfield
          //  fillColor: colorTrain_30,

          filled: true,
          hintStyle: const TextStyle(fontSize: 15, color: colorWhite),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorBlack),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10))),
      maxLines: 1,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class TextFiledEmail extends StatefulWidget {
  const TextFiledEmail(
      {Key? key, required this.hintText, required this.onChanged, this.text})
      : super(key: key);

  final String hintText;
  final Function(String) onChanged;
  final String? text;
  @override
  State<TextFiledEmail> createState() => _TextFiledEmailState();
}

class _TextFiledEmailState extends State<TextFiledEmail> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
    if (widget.text != null && widget.text!.isNotEmpty) {
      controller.text = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => {widget.onChanged(value)},
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'noti_vui_long_nhap_email'.tr();
        }
        if (!value.isValidPassword) {
          return 'noti_vui_long_nhap_email_hop_le'.tr();
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontSize: 15,
        color: colorWhite,
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: widget.hintText,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: colorWhite,
            size: 20,
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () => {controller.clear()},
                  icon: const Icon(
                    Icons.clear_outlined,
                    color: colorWhite,
                    size: 20,
                  ),
                ),
          filled: true,
          hintStyle: const TextStyle(fontSize: 15, color: colorWhite),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorBlack),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10))),
      maxLines: 1,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class TextFiledPassword extends StatefulWidget {
  TextFiledPassword(
      {Key? key, required this.hintText, required this.onChanged, this.text})
      : super(key: key);

  final String hintText;
  final Function(String) onChanged;
  String? text;
  @override
  State<TextFiledPassword> createState() => _TextFiledPasswordState();
}

class _TextFiledPasswordState extends State<TextFiledPassword> {
  bool enableIsPassword = true;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
    if (widget.text != null && widget.text!.isNotEmpty) {
      controller.text = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => {widget.onChanged(value)},
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'noti_vui_long_nhap_mat_khau'.tr();
        }
        if (!value.isValidPassword) {
          return 'noti_mat_khau_duoc_cung_cap_qua_yeu'.tr();
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,

      /// thay đổi kiểu của password
      obscureText: enableIsPassword,
      style: const TextStyle(
        fontSize: 15,
        color: colorWhite,
      ),
      decoration: InputDecoration(

          /// canh giua center text khi set chieu cao
          contentPadding: EdgeInsets.zero,
          hintText: widget.hintText,
          prefixIcon: const Icon(
            Icons.lock,
            color: colorWhite,
            size: 20,
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: enableIsPassword
                      ? const Icon(
                          Icons.remove_red_eye_outlined,
                          color: colorWhite,
                          size: 20,
                        )
                      : const Icon(
                          Icons.remove_red_eye,
                          color: colorWhite,
                          size: 20,
                        ),
                  onPressed: () =>
                      setState(() => {enableIsPassword = !enableIsPassword})),
          filled: true,
          hintStyle: const TextStyle(fontSize: 15, color: colorWhite),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorBlack),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10))),
      maxLines: 1,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
