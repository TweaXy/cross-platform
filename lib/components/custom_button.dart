import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  CustomButton(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressedCallback,
      required this.initialEnabled});
  String text;
  Color color;
  Function? onPressedCallback;
  bool initialEnabled;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  void setEnabled(bool value) {
    setState(() {
      widget.initialEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final onPressed = widget.initialEnabled ? widget.onPressedCallback : null;
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color, // Background color
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.5),
            side: BorderSide(color: Colors.blueGrey.shade200)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Text(
          widget.text,
          style: TextStyle(
              color: getTextColor(),
              fontWeight: FontWeight.w600,
              fontSize: widget.text == "Follow Back" ||
                      widget.text == 'Following' ||
                      widget.text == 'Follow'
                  ? 16
                  : 20),
        ),
      ),
    );
  }

  Color getTextColor() {
    Color textcolor = Colors.white;
    if (widget.initialEnabled == true) {
      if (widget.color == Colors.white) {
        textcolor = Colors.black;
      } else {
        textcolor = Colors.white;
      }
    } else {
      textcolor = Colors.white;
    }
    return textcolor;
  }
}
