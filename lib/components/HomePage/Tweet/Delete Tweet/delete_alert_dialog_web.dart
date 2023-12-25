import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/HomePage/MobileComponents/homepage_mobile.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/services/tweets_services.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';
import 'package:tweaxy/views/homepage.dart';

class DeleteAlertDialogWeb extends StatefulWidget {
  const DeleteAlertDialogWeb({super.key, required this.tweetId, required this.parentid});
  final String tweetId;
  final String parentid;
  @override
  State<DeleteAlertDialogWeb> createState() => _DeleteAlertDialogWebState();
}

class _DeleteAlertDialogWebState extends State<DeleteAlertDialogWeb> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width * 0.9;
    double screenheight = MediaQuery.of(context).size.width * 0.9;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenwidth * 0.41, vertical: screenheight * 0.1),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        titlePadding: const EdgeInsets.only(bottom: 0, left: 30, top: 30),
        contentPadding:
            const EdgeInsets.only(bottom: 15, left: 30, right: 30, top: 8),
        title: const Text('Delete post?',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(
                    255, 10, 10, 10))), // To display the title it is optional
        content: const Text(
            style:
                TextStyle(fontSize: 16, color: Color.fromARGB(255, 83, 83, 83)),
            'This can\'t be undone and it will be removed from your profile, the timeline of any accounts that follow you, and from search results.'), // Message which will be pop up on the screen
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                key: new ValueKey(DeleteTweetKeys.tweetDeleteConfirmMobile),
                style: ElevatedButton.styleFrom(
                  elevation: 0,

                  backgroundColor: const Color.fromARGB(255, 223, 54, 42),
                  padding: const EdgeInsets.all(20),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  //internal content margin
                ),
                onPressed: () async {
                  String t =
                      await TweetsServices.deleteTweet(tweetid: widget.tweetId);
                  Navigator.pop(context);
                  showToastWidget(
                      CustomWebToast(
                        message: t == "success" ? 'Your post was deleted' : t,
                      ),
                      position: ToastPosition.bottom,
                      duration: const Duration(seconds: 2));
                  print("t state" + t.toString());
                  if (t == "success")
                    BlocProvider.of<TweetsUpdateCubit>(context)
                  .deleteTweet(tweetid: widget.tweetId, parentid: widget.parentid);
                        
                },
                child: const Text('Delete',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 25),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                key: new ValueKey(DeleteTweetKeys.tweetCancelDeleteMobile),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  side: const BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 184, 184, 184)),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  //internal content margin
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
