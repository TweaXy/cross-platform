import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/Tweet/TweetSettings/wrap_modal_bottom_profile.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/get_user_by_id.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/tweet_keys.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class UserTweetInfoReply extends StatefulWidget {
  const UserTweetInfoReply(
      {super.key, required this.tweet, required this.replyto});
  final Tweet tweet;
  final List<String> replyto;
  @override
  State<UserTweetInfoReply> createState() => _UserTweetInfoReplyState();
}

class _UserTweetInfoReplyState extends State<UserTweetInfoReply> {
  bool isFutureComplete = false;

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
          future: GetUserById.instance.getUserById(widget.tweet.userId),
          builder: (context, snapshot) {
            if (!isFutureComplete) {
              // The future is not complete, show loading or an empty container
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              User user = snapshot.data!;
              String text = user.followedByMe!
                  ? 'Following'
                  : user.followsme!
                      ? 'Follow back'
                      : 'Follow';

              // String text = isfollowed[0]
              //     ? "Following"
              //     : isfollowed[1]
              //         ? "Follow Back"
              //         : "Follow";
              // print('llll' + isfollowed.toString());

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
                                BoxConstraints(maxWidth: screenwidth * 0.36),
                            child: Text(
                              maxLines: 1,
                              // tweet.userName.trim().length <= 5
                              //     ? '@${tweet.userHandle}'
                              //     : '${'@${tweet.userHandle.substring(0, 7)}'}...',
                              '@${widget.tweet.userHandle}',
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
                      if (TempUser.id != user.id)
                        FollowEditButton(
                          text: user.blockedByMe! ? 'Blocked' : text,
                          user: user,
                          key: const ValueKey(
                              TweetKeys.followButtonRepliesScreen),
                          forProfile: false,
                        ),
                        
                      IconButton(
                        key: const ValueKey(TweetKeys.deleteTweetRepliesScreen),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                        color: const Color.fromARGB(255, 182, 182, 182),
                        iconSize: 16,
                        onPressed: () {
                          if (widget.tweet.userId ==
                                  TempUser
                                      .id && //my post and not retweet or my post and my retweet
                              (!widget.tweet.isretweet ||
                                  widget.tweet.userId ==
                                      widget.tweet.reposteruserid)) {
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
                                  forreply: true,
                                  parentid: widget.tweet.parentid,
                                );
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                  widget.replyto.isNotEmpty
                      ? Padding(
                          padding:
                              const EdgeInsets.only(bottom: 8.0, right: 25),
                          child: Wrap(
                            children: [
                              RichText(
                                  text: TextSpan(
                                text: 'Replying to ',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 108, 108, 108),
                                  fontWeight: FontWeight.w400,
                                ),
                                children:
                                    widget.replyto.asMap().entries.map((e) {
                                  return TextSpan(
                                      text: '@${e.value}',
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if the FutureBuilder has completed
    if (!isFutureComplete) {
      // Update the flag to avoid unnecessary rebuilds
      setState(() {
        isFutureComplete = true;
      });
    }
  }
}
