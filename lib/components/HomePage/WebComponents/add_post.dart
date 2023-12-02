import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/components/add_tweet/Cutom_add_post_bar_web.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_text_field.dart';
import 'package:tweaxy/components/add_tweet/image_display_web.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/services/temp_user.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  List<XFile> xfilePick = [];
  bool showimages = false;
  final picker = ImagePicker();
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
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 0.2,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 135, 135, 135)
                    : const Color.fromARGB(255, 233, 233, 233))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              UserImageForTweet(
                image: TempUser.image,
                userid:'', text: '',
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01),
                    child: CustomAddTweetTextField(
                      key: const ValueKey("quick tweet add content"),
                      tweetController: tweetcontent,
                    )),
              )
            ],
          ),
          if (showimages)
            ImageDisplatWeb(
              pickedfiles: xfilePick,
              checkimagelist: postbutton,
            ),
          Padding(
              padding: EdgeInsets.only(
                  left: screenwidth * 0.03, bottom: screenheight * 0.007),
              child: CustomAddPostBarWeb(
                addTweetController: tweetcontent,
                getImage: getImages,
                postbuttonenabled: postbuttonenable,
                postbuttonpress: () {},
              ))
        ],
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
        showimages = true;
      });
      if (xfilePick.length > 4) {
        setState(() {
          showimages = false;
          xfilePick = [];
        });
      }
    }
    postbutton();
  }
}
