import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:tweaxy/services/get_conversation_service.dart';

class MessageIcon extends StatefulWidget {
  const MessageIcon({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<MessageIcon> createState() => _MessageIconState();
}

class _MessageIconState extends State<MessageIcon> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: GetUnseenConversationCount.getUnseenConversationCount(),
        builder: (context, snapshot) {
          return Badge(
            isLabelVisible: widget.selectedIndex == 3 ? false : true,
            offset: const Offset(6.0, -5.0),
            label: Text(snapshot.data.toString()),
            backgroundColor: Colors.blue,
            child: DecoratedIcon(
              icon: Icon(
                //
                FontAwesomeIcons.envelope,
                color: Theme.of(context).brightness == Brightness.light
                    ? (widget.selectedIndex == 3
                        ? Colors.black
                        : const Color.fromARGB(255, 137, 137, 137))
                    : (widget.selectedIndex == 3
                        ? Colors.white
                        : const Color.fromARGB(255, 176, 176, 176)),
              ),
              decoration: IconDecoration(
                  border: IconBorder(width: widget.selectedIndex == 3 ? 2 : 1)),
            ),
          );
        });
  }
}
