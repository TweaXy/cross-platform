import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_web/video_player_web.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer(
      {super.key, required this.pickedfiles, required this.checkimagelist});
  final List<XFile> pickedfiles;
  final Function checkimagelist;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // Set width to maximum
      height: widget.pickedfiles.isNotEmpty
          ? MediaQuery.of(context).size.height * 0.4
          : 0,
      child: IntrinsicHeight(
        child: GridView.builder(
          key: const ValueKey("grid display for images"),
          addRepaintBoundaries: false,
          itemCount: widget.pickedfiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (widget.pickedfiles[index].name.contains('.mp4') ||
                widget.pickedfiles[index].name.endsWith('.mov')) {
              return buildVideoElement(widget.pickedfiles[index]);
            } else {
              return buildImageElement(widget.pickedfiles[index]);
            }
          },
        ),
      ),
    );
  }

  void deleteFile(int index) {
    setState(() {
      widget.pickedfiles.removeAt(index);
      widget.checkimagelist();
    });
  }

  Widget buildImageElement(XFile image) {
    return Stack(
      children: [
        Image.network(
          image.path,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
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
}
