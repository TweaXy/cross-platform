import 'package:flutter/material.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/views/notifications/notification_screen.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class MutedUsersScreen extends StatefulWidget {
  const MutedUsersScreen({super.key});

  @override
  State<MutedUsersScreen> createState() => _MutedUsersScreenState();
}

class _MutedUsersScreenState extends State<MutedUsersScreen> {
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
          'Muted accounts',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            String _followStatus = 'Follow';
            return MutedUserListTile(followStatus: 'Follow');
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

class MutedUserListTile extends StatefulWidget {
  const MutedUserListTile({
    super.key,
    required this.followStatus,
  });
  final String followStatus;
  @override
  State<MutedUserListTile> createState() => _MutedUserListTileState();
}

class _MutedUserListTileState extends State<MutedUserListTile> {
  String _followStatus = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _followStatus = widget.followStatus;
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
                  text: _followStatus,
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
            flex: 3,
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
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    //Todo : Implement the unmute logic here
                  },
                  icon: const Icon(
                    Icons.volume_off_outlined,
                    color: Colors.redAccent,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_followStatus == 'Follow') {
                      //TODO :- Implement the follow logic
                      setState(() {
                        _followStatus = 'Following';
                      });
                    } else if (_followStatus == 'Following') {
                      //TODO :- Implement the unfollow logic
                      setState(() {
                        _followStatus = 'Follow';
                      });
                    }
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(3),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(
                          color: _followStatus == 'Follow'
                              ? Colors.transparent
                              : Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(80))),
                    backgroundColor: MaterialStatePropertyAll(
                        _followStatus == 'Follow'
                            ? Colors.black
                            : Colors.white),
                  ),
                  child: Text(
                    _followStatus,
                    style: TextStyle(
                      color: _followStatus == 'Follow'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                )
              ],
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
    ;
  }
}
