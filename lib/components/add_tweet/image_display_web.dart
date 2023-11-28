import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImageDisplatWeb extends StatefulWidget {
  const ImageDisplatWeb(
      {super.key, required this.pickedfiles, required this.checkimagelist});
  final List<XFile> pickedfiles;
  final Function checkimagelist;

  @override
  State<ImageDisplatWeb> createState() => _ImageDisplatWebState();
}

class _ImageDisplatWebState extends State<ImageDisplatWeb> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.pickedfiles.isNotEmpty
          ? MediaQuery.of(context).size.height * 0.4
          : 0,
      child: IntrinsicHeight(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (widget.pickedfiles.length == 1) {
              // If there's only one item, it takes the whole space
              return buildItem(widget.pickedfiles[0], constraints);
            } else if (widget.pickedfiles.length == 2) {
              // If there are two items, split the space horizontally
              return Row(
                children: [
                  buildItem(widget.pickedfiles[0], constraints),
                  buildItem(widget.pickedfiles[1], constraints),
                ],
              );
            } else if (widget.pickedfiles.length == 3) {
              // If there are three items, distribute space accordingly
              return Container(
                width: screenwidth * .3,
                height: screenheight * .3,
                child: Row(
                  children: [
                    buildItem(widget.pickedfiles[0], constraints),
                    Column(
                      children: [
                        buildItem(widget.pickedfiles[1], constraints),
                        buildItem(widget.pickedfiles[2], constraints),
                      ],
                    ),
                  ],
                ),
              );
            } else if (widget.pickedfiles.length == 4) {
              // If there are four items, distribute space evenly
              return Row(
                  children: [
                  Column(
                      children: [
                        buildItem(widget.pickedfiles[0], constraints),
                        buildItem(widget.pickedfiles[1], constraints),
                      ],
                    ),
                    Column(
                      children: [
                        buildItem(widget.pickedfiles[2], constraints),
                        buildItem(widget.pickedfiles[3], constraints),
                      ],
                    ),
                  ],
                );
            } else {
              // Handle other cases if needed
              return Container();
            }
          },
        ),
      ),
      // child: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     if (widget.pickedfiles.length == 1)
      //       Expanded(child: videoOrimage(widget.pickedfiles[0])),
      //     if (widget.pickedfiles.length == 2)
      //       Container(
      //         width: screenwidth * 0.36,
      //         child: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Expanded(child: videoOrimage(widget.pickedfiles[0])),
      //             Expanded(
      //                 child: videoOrimage(
      //               widget.pickedfiles[1],
      //             )),
      //           ],
      //         ),
      //       ),
      //     if (widget.pickedfiles.length == 3)
      //       Container(
      //         width: screenwidth * 0.36,
      //         child: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Expanded(child: videoOrimage(widget.pickedfiles[0])),
      //             Expanded(
      //                 child: Container(
      //               height: screenheight * 0.1,
      //               child: Column(
      //                 children: [
      //                   videoOrimage(widget.pickedfiles[1]),
      //                   videoOrimage(widget.pickedfiles[2])
      //                 ],
      //               ),
      //             )),
      //           ],
      //         ),
      //       ),
      //   ],
      // ),
    );
  }

  void deleteFile(int index) {
    setState(() {
      widget.pickedfiles.removeAt(index);
      widget.checkimagelist();
    });
  }

  Widget buildItem(XFile file, BoxConstraints constraints, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(child: videoOrimage(file)),
      ),
    );
  }

  Widget buildImageElement(XFile image) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: Image.network(
            image.path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: GestureDetector(
            key: const ValueKey("image removal button"),
            onTap: () {
              int index = widget.pickedfiles.indexOf(image);
              deleteFile(index);
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildVideoElement(XFile video) {
    final VideoPlayerController videoController =
        VideoPlayerController.networkUrl(
      Uri.parse(video.path),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
          ..setLooping(true)
          ..play()
          ..initialize().then((_) {
            setState(() {});
          }).catchError((error) {
            if (kDebugMode) {
              print("Error initializing video: $error");
            }
          });
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: videoController.value.aspectRatio,
          child: VideoPlayer(videoController),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: GestureDetector(
            key: const ValueKey("video removal button"),
            onTap: () {
              int index = widget.pickedfiles.indexOf(video);
              deleteFile(index);
            },
            child: const Icon(
              Icons.close,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget videoOrimage(XFile file) {
    if (file.name.contains('.mp4') || file.name.endsWith('.mov')) {
      return buildVideoElement(file);
    } else {
      return buildImageElement(file);
    }
  }
}
