import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_alert_dialog.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_button.dart';
import 'package:tweaxy/shared/keys/add_tweet_keys.dart';

class CusstomAddTweetAppbar extends StatelessWidget {
  const CusstomAddTweetAppbar({
    Key? key,
    required this.tweetController,
    required this.media,
    required this.isButtonEnabled,
    required this.isReply,
  }) : super(key: key);

  final TextEditingController tweetController;
  final List<XFile> media;
  final bool isButtonEnabled;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                key: const ValueKey(AddTweetKeys.discardTweet),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        CustomAddTweetAlertDialog(
                      text: isReply ? 'reply' : 'post',
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: CustomAddTweetButton(
                  isReply: isReply,
                  tweetcontent: tweetController,
                  xfilePick: media,
                  isButtonEnabled: isButtonEnabled,
                  textPadding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 2.0),
                ),
              ),
            ],
          ),
          isReply
              ? const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Divider(height: 0.0),
                )
              : Container(),
        ],
      ),
    );
  }
}
