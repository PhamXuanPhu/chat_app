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
    return TextField(
      onChanged: (value) => {widget.onChanged(value)},
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 15,
        color: colorWhite,
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: widget.hintText,
          prefixIcon: Icon(
            Icons.person,
            color: colorWhite,
            size: 20,
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () => {controller.clear()},
                  icon: Icon(
                    Icons.clear_outlined,
                    color: colorWhite,
                    size: 20,
                  ),
                ),

          ///fillColor, filled thay đổi màu background textfield
          //  fillColor: colorTrain_30,

          filled: true,
          hintStyle: TextStyle(fontSize: 15, color: colorWhite),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBlack),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10))),
      maxLines: 1,
    );
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
    return TextField(
      onChanged: (value) => {widget.onChanged(value)},
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      keyboardType: TextInputType.emailAddress,

      /// thay đổi kiểu của password
      obscureText: enableIsPassword,
      style: TextStyle(
        fontSize: 15,
        color: colorWhite,
      ),
      decoration: InputDecoration(

          /// canh giua center text khi set chieu cao
          contentPadding: EdgeInsets.zero,

          ///labelText: text,
          hintText: widget.hintText,

          /// thêm icon trước
          prefixIcon: Icon(
            Icons.lock,
            color: colorWhite,
            size: 20,
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: enableIsPassword
                      ? Icon(
                          Icons.remove_red_eye_outlined,
                          color: colorWhite,
                          size: 20,
                        )
                      : Icon(
                          Icons.remove_red_eye,
                          color: colorWhite,
                          size: 20,
                        ),
                  onPressed: () =>
                      setState(() => {enableIsPassword = !enableIsPassword})),

          ///fillColor, filled thay đổi màu background textfield
          // fillColor: colorTrain_30,

          filled: true,
          hintStyle: TextStyle(fontSize: 15, color: colorWhite),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBlack),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.circular(10))),
      maxLines: 1,
    );
  }
}
