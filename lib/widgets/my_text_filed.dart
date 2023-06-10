// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      required this.hintText,
      this.icon,
      required this.onChanged,
      this.validator,
      this.text,
      this.isPassword = false,
      this.readOnly = false,
      this.controller});

  final String hintText;
  final IconData? icon;
  final Function(String) onChanged;
  final String? Function(String)? validator;
  final String? text;
  final bool? isPassword;
  final bool readOnly;
  final TextEditingController? controller;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool enablePassword = true;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    }
    if (mounted) {
      _controller.addListener(() => setState(() {}));
    }
    if (widget.text != null && widget.text!.isNotEmpty) {
      _controller.text = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        widget.onChanged(value);
      },
      textAlignVertical: TextAlignVertical.center,
      controller: _controller,
      readOnly: widget.readOnly,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value!);
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      obscureText: widget.isPassword! ? enablePassword : false,
      style: TextStyle(
        fontSize: 15,
        color:
            widget.readOnly ? Colors.grey : Theme.of(context).selectedRowColor,
      ),
      decoration: InputDecoration(
          contentPadding: widget.icon == null
              ? const EdgeInsets.only(left: 20)
              : EdgeInsets.zero,
          hintText: widget.hintText,
          prefixIcon: widget.icon == null
              ? null
              : Icon(
                  widget.icon,
                  color: Theme.of(context).selectedRowColor,
                  size: 20,
                ),
          suffixIcon: (_controller.text.isEmpty || widget.readOnly)
              ? null
              : iconButton(),
          filled: true,
          fillColor: Theme.of(context).toggleableActiveColor,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).toggleableActiveColor),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).toggleableActiveColor),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).toggleableActiveColor),
              borderRadius: BorderRadius.circular(10))),
      maxLines: 1,
    );
  }

  Widget iconButton() {
    return widget.isPassword!
        ? IconButton(
            icon: enablePassword
                ? Icon(
                    Icons.remove_red_eye_outlined,
                    color: Theme.of(context).selectedRowColor,
                    size: 20,
                  )
                : Icon(
                    Icons.remove_red_eye,
                    color: Theme.of(context).selectedRowColor,
                    size: 20,
                  ),
            onPressed: () => setState(() => {enablePassword = !enablePassword}),
            splashRadius: 10,
          )
        : IconButton(
            onPressed: () {
              widget.onChanged('');
              _controller.clear();
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: Theme.of(context).selectedRowColor,
              size: 20,
            ),
            splashRadius: 10,
          );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
