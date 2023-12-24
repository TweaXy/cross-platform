import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_states.dart';
import 'package:tweaxy/services/mute_user_service.dart';

class MuteUserTweet extends StatelessWidget {
  MuteUserTweet(
      {super.key,
      required this.tweetid,
      required this.userHandle,
      required this.isMuted, required this.userid});
  final String tweetid;
  final String userHandle;
  final String userid;

  bool isMuted;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        BlocProvider.of<EditProfileCubit>(context)
            .emit(ProfilePageLoadingState());
        if (!isMuted) {
          var flag = await MuteUserService.mute(username: userHandle);
          print('Flag = $flag');
          if (flag) {
            muteAnimatedSnackBar(
              failure: false,
              icon: Icons.volume_off_outlined,
              muteFlag: true,
              mainContext: context,
              userName: userHandle,
            ).show(context);
            BlocProvider.of<TweetsUpdateCubit>(context).muteUser(userid);
          } else {
            muteAnimatedSnackBar(failure: true, muteFlag: false).show(context);
          }
        } else {
          var flag = await MuteUserService.unMuteUser(username: userHandle);
          print('Flag = $flag');
          if (flag) {
            muteAnimatedSnackBar(
              failure: false,
              icon: Icons.volume_mute_outlined,
              muteFlag: false,
              mainContext: context,
              userName: userHandle,
            ).show(context);
          } else {
            muteAnimatedSnackBar(failure: true, muteFlag: false).show(context);
          }
        }

        BlocProvider.of<EditProfileCubit>(context)
            .emit(ProfilePageCompletedState());

        Navigator.pop(context);
        //TODO: Implement Mute Logic
      },
      leading: Icon(
        Icons.volume_off_outlined,
        color: Colors.blueGrey[600],
      ),
      title: Text(
       isMuted? 'Unmute @${userHandle}':'Mute @${userHandle}',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

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
              style: const TextStyle(color: Colors.black, fontSize: 18),
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
                        userName: userHandle!,
                      ).show(context);
                      isMuted = false;
                    },
                    child: const Text('Undo'))
                : null,
          ),
        );
      }),
    );
  }
}
