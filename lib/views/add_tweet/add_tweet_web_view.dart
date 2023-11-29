import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/Components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/Components/add_tweet/Cutom_add_post_bar_web.dart';
import 'package:tweaxy/Components/add_tweet/custom_add_tweet_text_field.dart';
import 'package:tweaxy/Components/add_tweet/image_display_web.dart';

class AddTweetWebView extends StatefulWidget {
  const AddTweetWebView({super.key});

  @override
  State<AddTweetWebView> createState() => _AddTweetWebViewState();
}

class _AddTweetWebViewState extends State<AddTweetWebView> {
  List<XFile> xfilePick = [];
  final picker = ImagePicker();
  double dialogHight = 0;
  TextEditingController tweetcontent = TextEditingController();
  bool postbuttonenable = false;
  void postbutton() {
    if (xfilePick.isNotEmpty || tweetcontent.text.isNotEmpty) {
      setState(() {
        postbuttonenable = true;
      });
    } else {
      setState(() {
        postbuttonenable = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Add a listener to the TextEditingController
    tweetcontent.addListener(postbutton);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
      alignment: Alignment.topCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: IntrinsicHeight(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .4,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                  vertical: MediaQuery.of(context).size.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        key: const ValueKey("add tweet return button "),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_sharp)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.01),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const UserImageForTweet(image: 'assets/girl.jpg'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.0001),
                              child: CustomAddTweetTextField(
                                key: const ValueKey("post tweet content field"),
                                tweetController: tweetcontent,
                              )),
                        )
                      ],
                    ),
                  ),
                  if (xfilePick.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .01),
                      child: SizedBox(
                          child: ImageDisplatWeb(
                        pickedfiles: xfilePick,
                        checkimagelist: postbutton,
                      )),
                    ),
                  if (xfilePick.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    const Divider(
                      thickness: 2,
                    ),
                    CustomAddPostBarWeb(
                      addTweetController: tweetcontent,
                      getImage: getImages,
                      postbuttonenabled: postbuttonenable,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultipleMedia(
        requestFullMetadata: true,
        imageQuality: 4, // To set quality of images
        maxHeight: MediaQuery.of(context).size.height *
            0.4, // To set maxheight of images that you want in your app
        maxWidth: MediaQuery.of(context).size.width *
            0.4); // To set maxheight of images that you want in your app
    xfilePick.addAll(pickedFile);
    if (xfilePick.isNotEmpty) {
      setState(() {
        dialogHight = MediaQuery.of(context).size.height * .8;
      });
      if (xfilePick.length > 4) {
        xfilePick = [];
        setState(() {
          dialogHight = MediaQuery.of(context).size.height * .4;
        });
      }
    }
    postbutton();
  }
}
