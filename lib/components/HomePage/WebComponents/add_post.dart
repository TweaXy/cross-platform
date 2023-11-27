import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/Components/HomePage/WebComponents/image_viewer.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  List<XFile> xfilePick = [];
  bool showimages = false;
  final picker = ImagePicker();
TextEditingController tweetcontent=TextEditingController();
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
        children: [
           Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const UserImageForTweet(image: 'assets/girl.jpg'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.01),
                          child: TextField(
                            controller: tweetcontent,
                            maxLines: 7,
                            minLines: 1,
                            maxLength: 280,
                            decoration: const InputDecoration(
                              counterText: "",
                              hintText: 'What is hapenning?!',
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12),
                              hintStyle: TextStyle(
                                fontSize: 20,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          if (showimages) ImageViewer(pickedfiles: xfilePick),
          Padding(
            padding: EdgeInsets.only(
                left: screenwidth * 0.03, bottom: screenheight * 0.007),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 20,
                  hoverColor: const Color.fromARGB(255, 207, 232, 253),
                  icon: const Icon(FontAwesomeIcons.image),
                  color: Colors.blue.shade400,
                  iconSize: 17,
                  onPressed: () {getImages();},
                ),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    elevation: 20,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                   child: const Text(
                    'Post',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
                // IconButton(
                //   icon: Icon(FontAwesomeIcons.faceSmile),
                //   color: Colors.blue.shade400,
                //   iconSize: 17,
                //   onPressed: () {},
                // ),
                // Material(
                //   child: Ink(
                //     decoration: ShapeDecoration(
                //       shape: RoundedRectangleBorder(
                //         side: BorderSide(
                //           color: Colors.blue.shade400,
                //         ),
                //         borderRadius: BorderRadius.circular(4.0),
                //       ),
                //     ),
                //     child: IconButton(
                //       padding: EdgeInsets.zero,
                //       constraints: BoxConstraints(),
                //       icon: Icon(Icons.gif),
                //       color: Colors.blue.shade400,
                //       iconSize: 20,
                //       onPressed: () {},
                //     ),
                //   ),
                // ),
              ],
            ),
          )
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
  }
}
