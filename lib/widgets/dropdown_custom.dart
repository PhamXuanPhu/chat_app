// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T>? onChanged;

  const CustomDropdownButton({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  _CustomDropdownButtonState<T> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  bool _isExpanded = false;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                _toggleDropdown();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.value?.toString() ?? 'Select an item',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.shade700,
            ),
            onPressed: () {
              _toggleDropdown();
            },
          ),
        ],
      ),
    );
  }

  void _toggleDropdown() {
    if (_isExpanded) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);
      _overlayEntry = _createOverlayEntry(size, offset);
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  OverlayEntry _createOverlayEntry(Size size, Offset offset) {
    return OverlayEntry(builder: (BuildContext context) {
      return Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  widget.onChanged?.call(widget.items[index]);
                  _toggleDropdown();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    widget.items[index].toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: widget.items[index] == widget.value
                          ? Colors.black
                          // ? Theme.of(context).accentColor
                          : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class DropDownIcon extends StatefulWidget {
  final Widget item;
  const DropDownIcon({super.key, required this.item});

  @override
  State<DropDownIcon> createState() => _DropDownIconState();
}

class _DropDownIconState extends State<DropDownIcon> {
  bool _isExpanded = false;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 10,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.grey.shade700,
      ),
      onPressed: () {
        _toggleDropdown();
      },
    );
  }

  void _toggleDropdown() {
    if (_isExpanded) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);
      _overlayEntry = _createOverlayEntry(size, offset);
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  OverlayEntry _createOverlayEntry(Size size, Offset offset) {
    return OverlayEntry(builder: (BuildContext context) {
      return Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          width: 200,
          child: Container(
            color: Colors.red,
            child: widget.item,
          ));
    });
  }
}
