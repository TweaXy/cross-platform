import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/follow_user.dart';

class ModalBottomSheetTweet extends StatelessWidget {
  const ModalBottomSheetTweet({super.key, required this.tweet});
  final Tweet tweet;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          onTap: () async {
            Navigator.pop(context);
            await FollowUser.instance.deleteUser(tweet.userName);
            Fluttertoast.showToast(msg: 'You Unfollowed ${tweet.userName}');
          },
          leading: Icon(
            Icons.person_remove_outlined,
            color: Colors.blueGrey[600],
          ),
          title: Text(
            'Unfollow @${tweet.userName}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        ListTile(
          onTap: () async {
            Navigator.pop(context);
            
            AnimatedSnackBar muteAnimatedSnackBar(
                {IconData? icon,
                bool muteFlag = true,
                BuildContext? mainContext,
                bool failure = false,
                String userName = ''}) {
              String titleText = '';
              Color iconColor = Colors.blue[700]!;
              if (muteFlag) {
                titleText = 'You muted @$userName';
              } else {
                titleText = 'You unmuted @$userName';
              }
              return AnimatedSnackBar(
                mobileSnackBarPosition: MobileSnackBarPosition.top,
                mobilePositionSettings: const MobilePositionSettings(
                  left: 5,
                  right: 5,
                ),
                duration: const Duration(seconds: 3),
                builder: ((context) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: failure ? Colors.red[100] : Colors.blue[100],
                        border: Border.all(
                          color: Colors.blue[700]!,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: double.infinity,
                    child: ListTile(
                      title: Text(
                        failure ? 'Oops There\'s an error' : titleText,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      leading: Icon(
                        failure ? Icons.close : icon,
                        color: failure ? Colors.red : Colors.blue[700],
                      ),
                      subtitle: muteFlag
                          ? ElevatedButton(
                              onPressed: () {
                                muteAnimatedSnackBar(
                                  failure: false,
                                  icon: Icons.volume_off_outlined,
                                  muteFlag: false,
                                  mainContext: context,
                                  userName: tweet.userName!,
                                ).show(context);
                                // _isMuted = false;
                              },
                              child: const Text('Undo'))
                          : null,
                    ),
                  );
                }),
              );
            }
            //TODO: Implement Mute Logic
          },
          leading: Icon(
            Icons.volume_off_outlined,
            color: Colors.blueGrey[600],
          ),
          title: Text(
            'Mute @${tweet.userName}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        ListTile(
          onTap: () async {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                contentPadding: const EdgeInsets.all(20),
                title: Text(
                  'Block @${tweet.userName}',
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
                content: Text(
                  "@${tweet.userName} will no longer be able to follow or message you, and you will not see notifications from @${tweet.userName}",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )),
                  TextButton(
                      onPressed: () {
                        //TODO: Implement Block Logic
                        Navigator.pop(context);
                      },
                      child: const Text('Block',
                          style: TextStyle(color: Colors.black, fontSize: 16))),
                ],
              ),
            );
          },
          leading: Icon(
            Icons.block,
            color: Colors.blueGrey[600],
          ),
          title: Text(
            'Block @${tweet.userName}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
