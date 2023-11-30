import 'dart:async';
import 'dart:developer';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/Components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/Components/add_tweet/Cutom_add_post_bar_web.dart';
import 'package:tweaxy/Components/add_tweet/custom_add_tweet_text_field.dart';
import 'package:tweaxy/Components/add_tweet/image_display_web.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_alert_dialog.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/services/add_tweet.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class AddTweetWebView extends StatefulWidget {
  const AddTweetWebView({super.key});

  @override
  State<AddTweetWebView> createState() => _AddTweetWebViewState();
}

class _AddTweetWebViewState extends State<AddTweetWebView> {
  List<XFile> xfilePick = [];
  final List<Uint8List> bodylist = [];
  final List<Map<String, dynamic>> imagesData = [];
  final picker = ImagePicker();
  double dialogHight = 0;
  TextEditingController tweetcontent = TextEditingController();
  bool postbuttonenable = false;
  void postbutton() {
    if (imagesData.isNotEmpty || tweetcontent.text.isNotEmpty) {
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
                          if (tweetcontent.text.isNotEmpty ||
                              imagesData.isNotEmpty) {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  const CustomAddTweetAlertDialog(),
                            );
                          } else {
                            Navigator.pop(context);
                          }
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
                  if (imagesData.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .01),
                      child: SizedBox(
                          child: ImageDisplatWeb(
                        pickedfiles: imagesData,
                        checkimagelist: postbutton,
                      )),
                    ),
                  if (imagesData.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    const Divider(
                      thickness: 2,
                    ),
                    CustomAddPostBarWeb(
                        addTweetController: tweetcontent,
                        getImage: getImagesfiles,
                        postbuttonenabled: postbuttonenable,
                        postbuttonpress: () async {
                          if (tweetcontent.text.isNotEmpty ||
                              imagesData.isNotEmpty) {
                            AddTweet service = AddTweet(Dio());
                            dynamic response = await service.addTweetweb(
                                tweetcontent.text, bodylist);
                            print(response.toString());
                            if (response is String) {
                              showToastWidget(CustomWebToast(
                                  message: "fail ${response.toString()}"));
                            } else {
                              Navigator.pop(context);

                              showToastWidget(
                                  const CustomWebToast(message: "sucess"));
                            }
                          } else {
                            showToastWidget(const CustomWebToast(
                                message: "the tweet cant be empty"));
                          }
                        }),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getImagesfiles() async {
    // final html.InputElement input = html.InputElement(type: 'file')..multiple = true..accept = 'image/*';
    // final List<Map<String, dynamic>> imagesData = [];

    // // Simulate a click to trigger the file picker
    // input.click();

    // // Wait for the user to select files
    // await input.onChange.first;

    // // Access the selected files
    // final List<html.File> files = input.files!.toList();

    // // Read bytes and get paths for each file
    // for (final html.File file in files) {
    //   final Uint8List bytes = await _readFile(file);
    //   final String path = file.name;
    try {
      final FilePickerResult? pickedFiles = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.media,
        allowMultiple: true,
      );
      if (kDebugMode) {
        print('name  ${pickedFiles?.files[0].name}');
      }

      if (pickedFiles!.files.isNotEmpty) {
        setState(() {
          for (int i = 0; i < pickedFiles.files.length; i++) {
            imagesData.add({
              'path': pickedFiles.files[i].name,
              'bytes': pickedFiles.files[i].bytes,
            });
            bodylist.add(pickedFiles.files[i].bytes as Uint8List);
          }
        });
      }
      // if (pickedFiles != null) {
      //   setState(() {
      // for (int i = 0; i < pickedFiles.files.length; i++) {
      //   selectedImages.add(pickedFiles.files[i]);
      // }
      //   dialogHight = MediaQuery.of(context).size.height * .8;
      // selectedImagesstrings
      //     .addAll(pickedFiles.files.map((file) => file.path ?? ""));
      // if (kDebugMode) {
      //   print('selectedImagesstrings $selectedImagesstrings');
      // }
      // });
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
    }
    // Log the bytes of the first image
    // if (imagesData.length == 1) {
    //   log(imagesData[0]['bytes'].toString());
    // }

       postbutton();

    return imagesData;
  }

  // Future<Uint8List> _readFile(html.File file) async {
  //   final FileReader reader = FileReader();
  //   final Completer<Uint8List> completer = Completer();

  //   reader.onLoadEnd.listen((ProgressEvent event) {
  //     try {
  //       if (reader.readyState == FileReader.DONE) {
  //         completer.complete(Uint8List.fromList(reader.result as List<int>));
  //       }
  //     } catch (e) {
  //       print(e.toString());
  //       completer.completeError('Error converting bytes.');
  //     }
  //   });

  //   reader.onError.listen((Event event) {
  //     completer.completeError('File reading error.');
  //   });

  //   reader.readAsArrayBuffer(file);

  //   return completer.future;
  // }

  // Future getImages() async {
  //   final pickedFile = await picker.pickMultipleMedia(
  //       requestFullMetadata: true,
  //       imageQuality: 4, // To set quality of images
  //       maxHeight: MediaQuery.of(context).size.height *
  //           0.4, // To set maxheight of images that you want in your app
  //       maxWidth: MediaQuery.of(context).size.width *
  //           0.4); // To set maxheight of images that you want in your app
  //   xfilePick.addAll(pickedFile);
  //   if (xfilePick.isNotEmpty) {
  //     setState(() {
  //       dialogHight = MediaQuery.of(context).size.height * .8;
  //     });
  //     if (xfilePick.length > 4) {
  //       xfilePick = [];
  //       setState(() {
  //         dialogHight = MediaQuery.of(context).size.height * .4;
  //       });
  //     }
  //   }
  //   postbutton();
  // }
}
