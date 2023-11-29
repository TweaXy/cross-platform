import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_alert_dialog.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_button.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_text_field.dart';
import 'package:tweaxy/components/custom_circular_progress_indicator.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/shared/keys/add_tweet_keys.dart';
import 'package:video_player/video_player.dart';

class AddTweetView extends StatefulWidget {
  const AddTweetView({super.key, required this.photoIconPressed});
  final bool photoIconPressed;

  @override
  State<AddTweetView> createState() => _AddTweetViewState();
}

class _AddTweetViewState extends State<AddTweetView> {
  final TextEditingController _tweetController = TextEditingController();
  bool isButtonEnabled = false;
  List<XFile> media = [], mediaTemporary = [];
  List videoControllers = [];

  @override
  void initState() {
    super.initState();
    _tweetController.addListener(_updateButtonState);
    if (widget.photoIconPressed) {
      pickMedia();
    }
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = (_tweetController.text.isNotEmpty &&
              _tweetController.text.length <= 280) ||
          media.isNotEmpty;
    });
  }

  Future pickMedia() async {
    final ImagePicker picker = ImagePicker();
    try {
      mediaTemporary = await picker.pickMultipleMedia();

      setState(() {
        media.addAll(mediaTemporary);
      });

      for (XFile mediaItem in mediaTemporary) {
        if (mediaItem.name.endsWith('mp4')) {
          VideoPlayerController controller =
              VideoPlayerController.file(File(mediaItem.path))
                ..setLooping(false);

          controller.initialize().then((_) {
            // Adding the initialized controller to the list
            setState(() {
              videoControllers.add(controller);
            });

            // Add a listener to the VideoPlayerController
            videoControllers[media.indexOf(mediaItem)].addListener(() {
              if (!videoControllers[media.indexOf(mediaItem)].value.isPlaying &&
                  videoControllers[media.indexOf(mediaItem)]
                      .value
                      .isInitialized &&
                  (videoControllers[media.indexOf(mediaItem)].value.duration ==
                      videoControllers[media.indexOf(mediaItem)]
                          .value
                          .position)) {
                // Triggered when the video reaches the end
                setState(() {
                  videoControllers[media.indexOf(mediaItem)].pause();
                });
              }
            });

            // Set state after the VideoPlayerController is initialized
            setState(() {
              // Perform any state updates here after initialization
            });
          });
        } else {
          videoControllers.add(0);
        }
      }
    } catch (e) {
      setState(() {
        media = [];
      });
    }
  }

  cropImage({required int index}) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: media[index].path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            showCropGrid: false,
            hideBottomControls: false,
            cropFrameColor: Colors.transparent,
            toolbarTitle: 'Edit photo',
            backgroundColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            dimmedLayerColor: Colors.black.withOpacity(0.5)),
      ],
      cropStyle: CropStyle.rectangle,
    );

    if (cropped != null) {
      setState(() {
        media[index] = XFile(cropped.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
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
                            const CustomAddTweetAlertDialog(),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: CustomAddTweetButton(
                      tweetcontent: _tweetController,
                      xfilePick: media,
                      isButtonEnabled: isButtonEnabled,
                      textPadding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 2.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 0),
                    child: CircleAvatar(
                      radius: 21,
                      backgroundImage:
                          AssetImage('assets/girl.jpg'), //TODO : image of
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.1,
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: CustomAddTweetTextField(
                        key: const ValueKey(AddTweetKeys.tweetTextField),
                        tweetController: _tweetController),
                  ),
                ],
              ),
            ),
            if (videoControllers.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: videoControllers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: videoControllers[index]
                                  is VideoPlayerController
                              ? AspectRatio(
                                  aspectRatio:
                                      videoControllers[index].value.aspectRatio,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      VideoPlayer(videoControllers[index]),
                                      Center(
                                        child: IconButton(
                                          key: const ValueKey(
                                              AddTweetKeys.playPauseVideo),
                                          onPressed: () {
                                            setState(
                                              () {
                                                videoControllers[index]
                                                        .value
                                                        .isPlaying
                                                    ? videoControllers[index]
                                                        .pause()
                                                    : videoControllers[index]
                                                        .play();
                                              },
                                            );
                                          },
                                          icon: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              videoControllers[index]
                                                      .value
                                                      .isPlaying
                                                  ? Icons.pause_circle
                                                  : Icons.play_circle,
                                              color: const Color(0xFF1e9aeb),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        key: const ValueKey(
                                            AddTweetKeys.discardVideo),
                                        onPressed: () {
                                          setState(
                                            () {
                                              media.removeAt(index);
                                              videoControllers.removeAt(index);
                                            },
                                          );
                                        },
                                        icon: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black87,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            ' ${videoControllers[index].value.duration.inMinutes}:${videoControllers[index].value.duration.inSeconds.toString().padLeft(2, '0')}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              backgroundColor: Colors.black54,
                                            ),
                                          )),
                                    ],
                                  ),
                                )
                              : Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Image(
                                        image:
                                            FileImage(File(media[index].path))),
                                    IconButton(
                                      key: const ValueKey(
                                          AddTweetKeys.discardImage),
                                      onPressed: () {
                                        setState(() {
                                          media.removeAt(index);
                                          videoControllers.removeAt(index);
                                        });
                                      },
                                      icon: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black87,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        key: const ValueKey(
                                            AddTweetKeys.editImage),
                                        onPressed: () {
                                          setState(() {
                                            cropImage(index: index);
                                          });
                                        },
                                        icon: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black87,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    key: const ValueKey(AddTweetKeys.addMedia),
                    onPressed: () {
                      pickMedia();
                    },
                    icon: const Icon(
                      AppIcon.image,
                      color: Color(0xFF1e9aeb),
                    ),
                  ),
                  Row(
                    children: [
                      CusotmCircularProgressIndicator(
                          tweetController: _tweetController),
                      const VerticalDivider(
                        indent: 5,
                        endIndent: 5,
                        width: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          //TODO : add another tweet
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Color(0xFF1e9aeb),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
