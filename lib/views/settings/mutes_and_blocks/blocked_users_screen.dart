import 'package:flutter/material.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/views/notifications/notification_screen.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class BlockedUserScreen extends StatefulWidget {
  const BlockedUserScreen({super.key});

  @override
  State<BlockedUserScreen> createState() => _BlockedUserScreenState();
}

class _BlockedUserScreenState extends State<BlockedUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Blocked accounts',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return BlockedUserListTile(status: 'Blocked');
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[300],
            );
          },
          itemCount: 20),
    );
  }
}

class BlockedUserListTile extends StatefulWidget {
  const BlockedUserListTile({
    super.key,
    required this.status,
  });
  final String status;
  @override
  State<BlockedUserListTile> createState() => _BlockedUserListTileState();
}

class _BlockedUserListTileState extends State<BlockedUserListTile> {
  String _status = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        //Todo implement the list tile on press
        Navigator.push(
            context,
            CustomPageRoute(
                direction: AxisDirection.left,
                child: ProfileScreen(
                  id: '',
                  text: 'Blocked',
                )));
      },
      leading: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: CircleAvatarNotification(
            avatarURL: 'd1deecebfe9e00c91dec2de8bc0d68bb'),
      ),
      title: Row(
        children: [
          Expanded(
            flex: 11,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Samy as dasadas das d asdas',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  '@ahmedsamy',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_status == 'Follow') {
                    //TODO :- Implement the follow logic
                    setState(() {
                      _status = 'Following';
                    });
                  } else if (_status == 'Following') {
                    //TODO :- Implement the unfollow logic
                    setState(() {
                      _status = 'Follow';
                    });
                  } else {
                    //TODO :- Implement the unblock logic
                    setState(() {
                      _status = 'Follow';
                    });
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.fromLTRB(12, 8, 12, 8)),
                  elevation: const MaterialStatePropertyAll(3),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(
                        color: _status == 'Blocked'
                            ? Colors.transparent
                            : _status == 'Follow'
                                ? Colors.transparent
                                : Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(80))),
                  backgroundColor: MaterialStatePropertyAll(_status == 'Blocked'
                      ? Colors.redAccent
                      : _status == 'Follow'
                          ? Colors.black
                          : Colors.white),
                ),
                child: Text(
                  _status,
                  style: TextStyle(
                    color: _status != 'Following' ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      titleAlignment: ListTileTitleAlignment.top,
      subtitle: Text(
        'akfnaofknsoaifnsainf asjif s asf a sf asf asfaifj asijf sah fajshf uash fuhas fuhas fuh as asinfoiasfn ia sf i',
        style: TextStyle(
          color: Colors.black54,
          overflow: TextOverflow.clip,
        ),
        maxLines: 2,
      ),
    );
  }
}
