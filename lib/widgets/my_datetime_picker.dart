import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDatetimePicker extends StatefulWidget {
  const MyDatetimePicker({
    super.key,
    required this.hintText,
    required this.selected,
    this.controller,
    this.validator,
    this.datetime,
  });

  final String hintText;
  final String? Function(String)? validator;
  final DateTime? datetime;
  final Function(DateTime) selected;
  final TextEditingController? controller;

  @override
  State<MyDatetimePicker> createState() => MyDatetimePickerState();
}

class MyDatetimePickerState extends State<MyDatetimePicker> {
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
    if (widget.datetime != null) {
      _controller.text = DateFormat('dd-MM-yyyy').format(widget.datetime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        show(context);
      },
      textAlignVertical: TextAlignVertical.center,
      controller: _controller,
      readOnly: true,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value!);
        }
        return null;
      },
      style: TextStyle(
        fontSize: 15,
        color: Theme.of(context).selectedRowColor,
        overflow: TextOverflow.ellipsis,
      ),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          hintText: widget.hintText,
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    widget.selected(DateTime.now());
                    _controller.clear();
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Theme.of(context).selectedRowColor,
                    size: 20,
                  ),
                  splashRadius: 10,
                ),
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

  void show(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).toggleableActiveColor,
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.hintText),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 1,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 20,
                          )),
                    )
                  ],
                ),
                height10(value: 20),
                Expanded(
                  child: CupertinoDatePicker(
                      initialDateTime: widget.datetime ?? DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (value) {
                        widget.selected(value);
                        _controller.text =
                            DateFormat('dd-MM-yyyy').format(value);
                      }),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
