import 'package:flutter/material.dart';

class RadioCustom extends StatefulWidget {
  const RadioCustom(
      {super.key,
      required this.onPressed,
      required this.children,
      this.selected = 0});
  final Function(int) onPressed;
  final List<MyRadioButton> children;
  final int? selected;

  @override
  State<RadioCustom> createState() => _RadioCustomState();
}

class _RadioCustomState extends State<RadioCustom> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
            ),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(3),
        child: IntrinsicWidth(
          child: Row(
            children: widget.children
                .map((c) => MyRadioButton(
                    index: widget.children.indexOf(c),
                    iconData: c.iconData,
                    backgroundColor: selected == widget.children.indexOf(c)
                        ? Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor!
                        : Theme.of(context).scaffoldBackgroundColor,
                    width: c.width,
                    height: c.height,
                    iconColor: selected == widget.children.indexOf(c)
                        ? Colors.white
                        : Colors.grey.shade600,
                    onPressed: () {
                      setState(() {
                        selected = widget.children.indexOf(c);
                        widget.onPressed(widget.children.indexOf(c));
                      });
                    }))
                .toList(),
          ),
        ));
  }
}

class MyRadioButton extends StatelessWidget {
  final int? index;
  final IconData iconData;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const MyRadioButton(
      {super.key,
      this.index,
      required this.iconData,
      this.backgroundColor,
      this.iconColor,
      this.onPressed,
      this.width = 50,
      this.height = 30});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: backgroundColor,
          side: BorderSide(
            width: 0,
            color: backgroundColor!,
          ),
        ),
        child: Icon(
          iconData,
          size: 15,
          color: iconColor,
        ),
      ),
    );
  }
}
