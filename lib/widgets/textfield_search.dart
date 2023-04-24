import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TextFiledSearch extends StatefulWidget {
  const TextFiledSearch(
      {Key? key, required this.onChanged, required this.hintText})
      : super(key: key);

  final Function(String) onChanged;
  final String hintText;
  @override
  State<TextFiledSearch> createState() => _TextFiledSearchState();
}

class _TextFiledSearchState extends State<TextFiledSearch> {
  bool enableIsPassword = true;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => {widget.onChanged(value)},
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: widget.hintText,
          prefixIcon: const Icon(
            Icons.search_outlined,
            color: Colors.grey,
            size: 20,
          ),
          filled: true,
          fillColor: const Color.fromRGBO(240, 240, 240, 1),
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
              borderRadius: BorderRadius.circular(15)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
              borderRadius: BorderRadius.circular(15)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
              borderRadius: BorderRadius.circular(15))),
      maxLines: 1,
    );
  }
}
