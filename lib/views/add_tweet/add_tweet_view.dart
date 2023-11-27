import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/components/add_tweet/custom_add_tweet_button.dart';
import 'package:tweaxy/components/custom_circular_progress_indicator.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:video_player/video_player.dart';

class AddTweetView extends StatefulWidget {
  const AddTweetView({super.key});

  @override
  State<AddTweetView> createState() => _AddTweetViewState();
}

class _AddTweetViewState extends State<AddTweetView> {
  final TextEditingController _tweetController = TextEditingController();
  bool isButtonEnabled = false;
  List<XFile> media = [], mediaTemporary = [];
  List<VideoPlayerController> videoControllers = [];

  @override
  void initState() {
    super.initState();
    _tweetController.addListener(_updateButtonState);
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
        videoControllers.add(VideoPlayerController.file(File(media.last.path))
          ..setLooping(false)
          ..initialize().then((_) => videoControllers.last.pause()));

        isButtonEnabled = true;
      });
    } catch (e) {
      setState(() {
        media = [];
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
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child:
                        CustomAddTweetButton(isButtonEnabled: isButtonEnabled),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02,
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 23,
                    backgroundImage:
                        AssetImage('assets/girl.jpg'), //TODO : image of
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.84,
                    child: TextFormField(
                      controller: _tweetController,
                      maxLength: 280,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLines: 9,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        counterText: '',
                        hintText: 'What\'s happening?',
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 18),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (media.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: media.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: media[index].name.endsWith('mp4')
                              ? AspectRatio(
                                  aspectRatio:
                                      videoControllers[index].value.aspectRatio,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      VideoPlayer(videoControllers[index]),
                                      Center(
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              videoControllers[index]
                                                      .value
                                                      .isPlaying
                                                  ? videoControllers[index]
                                                      .pause()
                                                  : videoControllers[index]
                                                      .play();
                                            });
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
                                        onPressed: () {
                                          setState(() {
                                            media.removeAt(index);
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
                                      onPressed: () {
                                        setState(() {
                                          media.removeAt(index);
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      pickMedia();
                    },
                    icon: const Icon(
                      AppIcon.image,
                      color: Color(0xFF1e9aeb),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.64),
                    child: CusotmCircularProgressIndicator(
                        tweetController: _tweetController),
                  ),
                  const VerticalDivider(
                    indent: 5,
                    endIndent: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        //TODO : add another tweet
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Color(0xFF1e9aeb),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
