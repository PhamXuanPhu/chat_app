import 'package:chat_app/widgets/my_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/select_item.dart';
import '../services/toast_service.dart';

class MyLookup extends StatefulWidget {
  const MyLookup({
    super.key,
    required this.hintText,
    required this.listItem,
    required this.selected,
    this.controller,
    this.validator,
    this.selectItem,
  });

  final String hintText;
  final List<SelectItem> listItem;
  final String? Function(String)? validator;
  final SelectItem? selectItem;
  final Function(SelectItem) selected;
  final TextEditingController? controller;

  @override
  State<MyLookup> createState() => MyLookupState();
}

class MyLookupState extends State<MyLookup> {
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
    if (widget.selectItem != null &&
        widget.selectItem!.id.isNotEmpty &&
        widget.selectItem!.name.isNotEmpty) {
      _controller.text = widget.selectItem!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        if (widget.listItem.isNotEmpty) {
          showDialog(context);
        } else {
          Toast.message(message: 'noti_loi_he_thong'.tr(), context: context);
        }
      },
      textAlignVertical: TextAlignVertical.center,
      controller: _controller,
      readOnly: true,
      validator: (value) {
        return widget.validator!(value!);
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
                    widget.selected(SelectItem());
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

  void showDialog(BuildContext context) {
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
                  child: ListView.separated(
                    itemCount: widget.listItem.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _controller.text = widget.listItem[index].name;
                          widget.selected(widget.listItem[index].copyWith());
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            widget.listItem[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Theme.of(context).selectedRowColor,
                      );
                    },
                  ),
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
