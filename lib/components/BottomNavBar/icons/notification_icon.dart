
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/services/get_unseen_notification_count.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: GetUnseenNotificationCount.getUnseenNotificationCount(),
        builder: (context, snapshot) {
          return Badge(
            isLabelVisible: widget.selectedIndex == 2 ||
                    snapshot.data == null ||
                    snapshot.data == 0
                ? false
                : true,
            offset: const Offset(6.0, -5.0),
            label: Text(snapshot.data.toString()),
            backgroundColor: Colors.blue,
            child: Icon(
              //  Theme.of(context).brightness == Brightness.light
              //     ? (selectedIndex == 1
              //         ? Colors.black
              //         : Color.fromARGB(255, 137, 137, 137))
              //     : (selectedIndex == 1
              //         ? Colors.white
              //         : const Color.fromARGB(255, 203, 203, 203)),
              FontAwesomeIcons.bell,
              color: Theme.of(context).brightness == Brightness.light
                  ? (widget.selectedIndex == 2
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : const Color.fromARGB(255, 93, 93, 93))
                  : (widget.selectedIndex == 2
                      ? Colors.white
                      : const Color.fromARGB(255, 176, 176, 176)),
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
