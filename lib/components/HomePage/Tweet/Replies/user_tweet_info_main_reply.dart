import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/TweetSettings/wrap_modal_bottom_profile.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_states.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_states.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/follow_user.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/views/loading_screen.dart';

class UserTweetInfoReply extends StatefulWidget {
  const UserTweetInfoReply(
      {super.key, required this.tweet, required this.replyto});
  final Tweet tweet;
  final List<String> replyto;
  @override
  State<UserTweetInfoReply> createState() => _UserTweetInfoReplyState();
}

class _UserTweetInfoReplyState extends State<UserTweetInfoReply> {
  late List<bool> isfollowed = [];

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    // Future<String> isfollowedwait =
    //     TweetsServices.isFollowed(widget.tweet.userId) ;
    //     String isfollowed=isfollowedwait as String
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: FutureBuilder(
          future: TweetsServices.isFollowed(widget.tweet.userId),
          builder: (context, snapshot) {
            print('llll' + snapshot.data.toString());

            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              isfollowed = snapshot.data!;

              String text = isfollowed[0]
                  ? "Following"
                  : isfollowed[1]
                      ? "Follow Back"
                      : "Follow";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: screenwidth * 0.45),
                            child: Text(
                              maxLines: 1,
                              widget.tweet.userName,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Color.fromARGB(255, 12, 12, 12),
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: screenwidth * 0.45),
                            child: Text(
                              maxLines: 1,
                              // tweet.userName.trim().length <= 5
                              //     ? '@${tweet.userHandle}'
                              //     : '${'@${tweet.userHandle.substring(0, 7)}'}...',
                              '${'@' + widget.tweet.userHandle.toString()}',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                color: Color.fromARGB(255, 108, 108, 108),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // if (isfollowed != "Following" || count == 2)
                      if (!isfollowed[2])
                        CustomButton(
                          color: isfollowed[0] ? Colors.white : Colors.black,
                          text: text,
                          onPressedCallback: () {
                            BlocProvider.of<EditProfileCubit>(context)
                                .emit(ProfilePageLoadingState());

                            setState(() {
                              if (!isfollowed[0]) {
                                FollowUser.instance
                                    .followUser(widget.tweet.userHandle);
                                isfollowed[0] = true;
                                text = "Following";
                              } else {
                                FollowUser.instance
                                    .deleteUser(widget.tweet.userHandle);
                                isfollowed[0] = false;
                                text = isfollowed[1] ? "Follow Back" : "Follow";
                              }
                            });
                            // BlocProvider.of<UpdateAllCubit>(context)
                            //     .emit(LoadingStata());
                            BlocProvider.of<EditProfileCubit>(context)
                                .emit(ProfilePageCompletedState());
                          },
                          initialEnabled: true,
                        ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                        color: const Color.fromARGB(255, 182, 182, 182),
                        iconSize: 16,
                        onPressed: () {
                          if (widget.tweet.userId == TempUser.id) {
                            showModalBottomSheet(
                              showDragHandle: true,
                              useSafeArea: false,
                              enableDrag: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.0),
                                ),
                              ),
                              builder: (context) {
                                return WrapModalBottomProfile(
                                  tweetid: widget.tweet.id,
                                );
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                  widget.replyto.length > 0
                      ? Padding(
                          padding:
                              const EdgeInsets.only(bottom: 8.0, right: 25),
                          child: Wrap(
                            children: [
                              RichText(
                                  text: TextSpan(
                                text: 'Replying to ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 108, 108, 108),
                                  fontWeight: FontWeight.w400,
                                ),
                                children:
                                    widget.replyto.asMap().entries.map((e) {
                                  return TextSpan(
                                      text: '${'@' + e.value}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: Colors.blue),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: (e.key !=
                                                    widget.replyto.length - 1)
                                                ? ' and '
                                                : '')
                                      ]);
                                }).toList(),
                              ))
                            ],
                          ),
                        )
                      : Container()
                ],
              );
            }
          }),
    );
  }
}
