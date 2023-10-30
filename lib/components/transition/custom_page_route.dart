import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomPageRoute({required this.child, required this.direction})
      : super(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => child);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    return SlideTransition(
      position: Tween<Offset>(
        begin: getBeiginOffset(),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  getBeiginOffset() {
    switch (direction) {
      case AxisDirection.right:
        return Offset(-1, 0);
      case AxisDirection.left:
        return Offset(1, 0);
      default:
    }
  }
}
