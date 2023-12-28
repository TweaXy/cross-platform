import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/network_video_player.dart';

class FullScreenVideo extends StatelessWidget {
  const FullScreenVideo({super.key, required this.video});
  final String video;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.5,
          leading: const BackButton(color: Colors.white),
          title: const Text(
            'Video Show',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          child: SizedBox(
            width: screenWidth,
            height: screenHeight * 0.6,
            child: NetworkVideoPlayer(video: video),
          ),
        ));
  }
}
