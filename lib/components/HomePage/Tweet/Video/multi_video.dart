import 'package:flutter/material.dart';
import 'package:multi_video_player/multi_video_player.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/network_video_player.dart';

class MultiVideo extends StatelessWidget {
  MultiVideo({super.key});
  List<dynamic> videos = [
    'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  ];
  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   width: 50,
    //   height: 50,
    //   child: Row(
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       NetworkVideoPlayer(video: ''),
    //       NetworkVideoPlayer(video: '')
    //     ],
    //   ),
    // );
    return MultiVideoPlayer.network(
      height: 400,
      width: MediaQuery.of(context).size.width,
      videoSourceList: videos,
      scrollDirection: Axis.horizontal,
      preloadPagesCount: 2,
      onPageChanged: (videoPlayerController, index) {},
      getCurrentVideoController: (videoPlayerController) {},
    );
  }
}
