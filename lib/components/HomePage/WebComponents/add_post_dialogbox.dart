import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/Components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/Components/HomePage/WebComponents/image_viewer.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/services/add_tweet.dart';
import 'package:video_player/video_player.dart';

class AddPostDialogBox extends StatefulWidget {
  const AddPostDialogBox({super.key});

  @override
  State<AddPostDialogBox> createState() => _AddPostDialogBoxState();
}

class _AddPostDialogBoxState extends State<AddPostDialogBox> {
  List<XFile> xfilePick = [];
  final picker = ImagePicker();
  double dialogHight = 0;
  TextEditingController tweetcontent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (xfilePick.isEmpty) {
      setState(() {
        // dialogHight = MediaQuery.of(context).size.height * .3;
      });
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child:  IntrinsicHeight(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*.5,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01),
                child: Column(
                  
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                                        onPressed: () {
                      Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close_sharp)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const UserImageForTweet(image: 'assets/girl.jpg'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.0001),
                            child: TextField(
                              controller: tweetcontent,
                              maxLines: 7,
                              minLines: 1,
                              maxLength: 280,
                              decoration: const InputDecoration(
                                counterText: "",
                                hintText: 'What is hapenning?!',
                                
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
                    if (xfilePick.isNotEmpty)
                     Padding(
                       padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.01),
                       child: SizedBox(
                        child: ImageViewer(pickedfiles: xfilePick)),
                     ),
                     Column(mainAxisSize: MainAxisSize.min, children: [
                       const Divider(
                         thickness: 2,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           IconButton(
                             splashRadius: 20,
                             hoverColor: const Color.fromARGB(255, 207, 232, 253),
                             icon: const Icon(FontAwesomeIcons.image),
                             color: Colors.blue.shade400,
                             iconSize: 17,
                             onPressed: () {
                               getImages();
                               // await pickImage();
                             },
                           ),
                           ElevatedButton(
                             onPressed: () async {
                               if (tweetcontent.text.isNotEmpty ||
                                   xfilePick.isNotEmpty) {
                                 AddTweet service = AddTweet(Dio());
                                 Future response = await service.addTweet(
                                     tweetcontent.text, xfilePick);
                               } else {
                                 // showToastWidget(const CustomWebToast(
                                 //     message: "the tweet cant be empty"));
                               }
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
                               style:
                                   TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                             ),
                           )
                         ],
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
        xfilePick=[];
        setState(() {
          dialogHight = MediaQuery.of(context).size.height * .4;
        });
      }
    }
  }
 
}
