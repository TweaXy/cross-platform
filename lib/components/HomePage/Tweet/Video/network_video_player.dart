import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/Video/video_player_controller.dart';
import 'package:video_player/video_player.dart';

class NetworkPlayerWidget extends StatefulWidget {
  const NetworkPlayerWidget({super.key, required this.video});
  final String video;

  @override
  _NetworkPlayerWidgetState createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset('/assets/video (2160p).mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            VideoPlayerWidget(controller: controller),
          ],
        ),
      );
}
