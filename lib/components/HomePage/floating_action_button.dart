import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/app_icons.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          splashColor: Color.fromARGB(255, 156, 203, 250),
          highlightElevation: 0,
        ),
      ),
      child: Transform.scale(
        scale: 1.2, // Adjust the scale factor to increase the size
        child: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          // openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,

          buttonSize: const Size.fromRadius(
              28), // SpeedDial size which defaults to 56 itself

          /// The active label of the main button, Defaults to label if not specified.
          activeLabel: const Text("Post"),
          childrenButtonSize: const Size.fromRadius(26),
          visible: true,
          direction: SpeedDialDirection.up,
          switchLabelPosition: false,

          /// If true user is forced to close dial manually
          closeManually: false,

          /// If false, backgroundOverlay will not be rendered.
          renderOverlay: true,
          useRotationAnimation: true,

          elevation: 8.0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          animationDuration: const Duration(milliseconds: 200),

          children: [
            SpeedDialChild(
              child: const Icon(AppIcon.fabTweet),
              backgroundColor: Colors.white,
              foregroundColor: Colors.blueAccent,
              labelWidget: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  'Post',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, kAddTweetScreen);
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.photo_outlined),
              backgroundColor: Colors.white,
              foregroundColor: Colors.blueAccent,
              labelWidget: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  'Photos',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onTap: () {
                //TODO :- Add Photos Functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
