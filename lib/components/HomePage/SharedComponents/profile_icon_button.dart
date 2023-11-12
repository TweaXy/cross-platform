import 'package:flutter/material.dart';
import 'package:tweaxy/constants.dart';

class ProfileIconButton extends StatefulWidget {
  const ProfileIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
    required this.iconColor,
    required this.borderWidth,
  });
  final Function() onPressed;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double borderWidth;

  @override
  State<ProfileIconButton> createState() => _ProfileIconButtonState();
}

class _ProfileIconButtonState extends State<ProfileIconButton> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          hovered = value;
        });
      },
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color == Colors.white
              ? (hovered ? kGreyHoveredColor : Colors.white)
              : widget.color.withOpacity(0.5),
          border: widget.iconColor != Colors.white
              ? Border.all(color: Colors.black26, width: widget.borderWidth)
              : Border.all(color: Colors.transparent),
        ),
        padding: const EdgeInsets.all(4),
        child: Icon(
          widget.icon,
          color: widget.iconColor,
        ),
      ),
    );
  }
}
