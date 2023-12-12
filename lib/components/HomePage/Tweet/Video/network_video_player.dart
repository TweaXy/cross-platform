import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayer extends StatefulWidget {
  const NetworkVideoPlayer({super.key, required this.video});
  final String video;

  @override
  _NetworkVideoPlayerState createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  VideoPlayerController controller = VideoPlayerController.networkUrl(Uri.parse(
      'https://www.shutterstock.com/shutterstock/videos/1089393687/preview/stock-footage--seconds-countdown-timer-animation-neon-glowing-countdown-number.webm'));
  @override
  void initState() {
    super.initState();

    // controller = VideoPlayerController.asset('/assets/video (2160p).mp4')
    //   ..addListener(() => setState(() {}))
    //   ..setLooping(true)
    //   ..initialize().then((_) => controller.play());
    controller..setLooping(false);

    controller.initialize().then((_) {
      // Adding the initialized controller to the list

      // Add a listener to the VideoPlayerController
      controller.addListener(() {
        if (controller.value.isPlaying &&
            controller.value.isInitialized &&
            (controller.value.duration == controller.value.position)) {
          // Triggered when the video reaches the end
          setState(() {
            controller.pause();
          });
        }
      });

      // Set state after the VideoPlayerController is initialized
      setState(() {
        // Perform any state updates here after initialization
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: 100,
        height: 50,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
        
              // aspectRatio: controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  VideoPlayer(controller),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            controller.value.isPlaying
                                ? controller.pause()
                                : controller.play();
                          },
                        );
                      },
                      icon: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          controller.value.isPlaying
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          color: const Color(0xFF1e9aeb),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        ' ${controller.value.duration.inMinutes}:${controller.value.duration.inSeconds.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.black54,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      );
}
