import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multi_video_player/multi_video_player.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/network_video_player.dart';

class MultiVideo extends StatelessWidget {
  MultiVideo({super.key, required this.videos});
  final List<String>videos;
  @override
  Widget build(BuildContext context) {
    int i = 0;
  return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: videos.map((video) {
            i++;

          return StaggeredGridTile.count(
            crossAxisCellCount: videos.length == 1 ? 2 : 1,
            mainAxisCellCount: videos.length == 3 && i == 1 || videos.length == 1 ? 2 : 1,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return NetworkVideoPlayer(video: video);
              },
            ),
          );
        }).toList(),)
    );
  }
}