import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multi_video_player/multi_video_player.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/network_video_player.dart';

class MultiVideo extends StatelessWidget {
  MultiVideo({super.key, required this.videos});
  final List<String>videos;
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
  return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: videos.map((video) {
          return StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return AspectRatio(
                  aspectRatio: constraints.maxWidth / constraints.maxHeight,
                  child: NetworkVideoPlayer(video: video),
                );
              },
            ),
          );
        }).toList(),)
    );
  }
}