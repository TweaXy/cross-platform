import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_layout/multi_image_layout.dart';
import 'package:video_player/video_player.dart';

class TweetMedia extends StatefulWidget {
  const TweetMedia({super.key, required this.pickedfiles});
  final List<String> pickedfiles;

  @override
  State<TweetMedia> createState() => _TweetMediaState();
}

//
class _TweetMediaState extends State<TweetMedia> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    List<String> s = widget.pickedfiles.map((item) => '').toList();

    return MultiImageViewer(
      // captions: s,
      images: widget.pickedfiles,
      // height: screenheight * 0.3,
    );
    // return Container();
  }

  Widget buildItem(String file, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Center(child: videoOrimage(file)),
      ),
    );
  }

  Future<List<int>> getImageInfo(String image) async {
    var img = await rootBundle.load(image);
    var decodedImage = await decodeImageFromList(img.buffer.asUint8List());
    return [decodedImage.width, decodedImage.height];
  }

  Widget buildImageElement(String image) {
    Future<List<int>> s =
        getImageInfo('http://16.171.65.142:3000/uploads/tweetsMedia/$image');
    // print(future.s[0]);
    return AspectRatio(
      aspectRatio: 16 / 16,
      child: Image.network(
        'http://16.171.65.142:3000/uploads/tweetsMedia/$image',
        fit: BoxFit.fill,
        // width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget buildVideoElement(String video) {
    final VideoPlayerController videoController =
        VideoPlayerController.networkUrl(
      Uri.parse('http://16.171.65.142:3000/uploads/tweetsMedia/$video'),
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
        // Positioned(
        //   top: 8,
        //   left: 8,
        //   child: GestureDetector(
        //     key: const ValueKey("video removal button"),
        //     onTap: () {
        //       int index = widget.pickedfiles.indexOf(video);
        //       deleteFile(index);
        //     },
        //     child: Container(
        //       decoration: const BoxDecoration(
        //         color: Colors.white,
        //         shape: BoxShape.circle,
        //       ),
        //       child: const Icon(

        //         Icons.close,
        //         color: Colors.black,
        //         size: 24,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget videoOrimage(String file) {
    if (file.contains('.mp4') || file.endsWith('.mov')) {
      return buildVideoElement(file);
    } else {
      return buildImageElement(file);
    }
  }
}
