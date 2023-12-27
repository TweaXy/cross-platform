import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/main_tweet_for_replies.dart';
import 'package:tweaxy/components/HomePage/Tweet/Replies/replies_list.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_button.dart';
import 'package:tweaxy/components/custom_circular_progress_indicator.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/Tweets/tweet_states.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/add_reply_keys.dart';
import 'package:tweaxy/views/add_tweet/add_tweet_view.dart';

class RepliesScreen extends StatefulWidget {
  const RepliesScreen(
      {super.key,
      required this.tweetid,
      required this.replyto,
      required this.userHandle,
      required this.isARepost,
      required this.reposteruserName});
  final String tweetid;
  final List<String> replyto;
  final String userHandle;
  final bool isARepost;
  final String reposteruserName;

  @override
  State<RepliesScreen> createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  final TextEditingController tweetController = TextEditingController();
  bool isNotEmpty = false;
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    tweetController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {
      isNotEmpty = tweetController.text.trim().isNotEmpty || isTapped;
    });
  }

  // void dispose() {
  //   tweetController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    List<String> replytochild = new List.from(widget.replyto);
    replytochild.add(widget.userHandle);
    return BlocBuilder<TweetsUpdateCubit, TweetUpdateState>(
      builder: (context, state) {
        // if (state is TweetDeleteState && state.tweetid == widget.tweet.id)
        // // add your code here.
        // {

        //   Navigator.pop(context);
        // }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            leading: const BackButton(color: Colors.black),
            title: const Text(
              'Post',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: MainTweetReplies(
                  tweetid: widget.tweetid,
                  replyto: widget.replyto,
                  isARepost: widget.isARepost,
                  reposteruserName: widget.reposteruserName,
                )),
                RepliesList(
                  replyto: replytochild as List<String>,
                  mainTweetId: widget.tweetid,
                )
              ],
            ),
          ),
          bottomSheet: TempUser.username == widget.userHandle
              ? const SizedBox(
                  width: 0,
                  height: 0,
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Divider(
                        height: 5.0,
                        thickness: 0.5,
                      ),
                      isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: CustomReplytoRow(
                                replyto: [
                                  widget.userHandle,
                                ],
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: TextFormField(
                          key: const ValueKey(AddReplysKeys.addReplyTextfield),
                          onTap: () {
                            setState(() {
                              isTapped = true;
                            });
                          },
                          controller: tweetController,
                          maxLines: 3,
                          minLines: 1,
                          maxLength: 280,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              key:
                                  const ValueKey(AddReplysKeys.addReplyEnlarge),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTweetView(
                                      text: tweetController.text,
                                      replyto: widget.userHandle,
                                      isReply: true,
                                      tweetId: widget.tweetid,
                                      photoIconPressed: false,
                                    ),
                                  ),
                                );
                              },
                              icon: Transform.rotate(
                                angle: 4.7,
                                child: const Icon(
                                  AppIcon.enlarge,
                                  color: Color(0xFF1e9aeb),
                                  size: 20,
                                ),
                              ),
                            ),
                            hintText: 'Post your reply',
                            hintStyle: const TextStyle(
                              fontSize: 15,
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                            ),
                            counterText: '',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            key:
                                const ValueKey(AddReplysKeys.addReplyWithImage),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTweetView(
                                    text: tweetController.text,
                                    replyto: widget.userHandle,
                                    isReply: true,
                                    tweetId: widget.tweetid,
                                    photoIconPressed: true,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              AppIcon.image,
                              color: Color(0xFF1e9aeb),
                              size: 20,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: CusotmCircularProgressIndicator(
                                    tweetController: tweetController),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 8.0),
                                child: CustomAddTweetButton(
                                  key: const ValueKey(
                                      AddReplysKeys.addReplyButton),
                                  isReply: true,
                                  tweetId: widget.tweetid,
                                  tweetcontent: tweetController,
                                  xfilePick: const [],
                                  isButtonEnabled:
                                      tweetController.text.trim().isNotEmpty,
                                  textPadding: const EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 2.0),
                                  forReplyScreen: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class CustomReplytoRow extends StatelessWidget {
  const CustomReplytoRow({
    super.key,
    required this.replyto,
  });

  final List<String> replyto;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "Replying to ",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 17,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            '@${replyto[0]}',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
