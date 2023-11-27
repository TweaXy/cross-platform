import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer( {super.key, required this.pickedfiles});
final List<XFile> pickedfiles;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Set width to maximum
                      height:widget. pickedfiles.isNotEmpty
                          ? MediaQuery.of(context).size.height * 0.4
                          : 0,
                      child: GridView.builder(
                        addRepaintBoundaries: false,
                        itemCount:widget. pickedfiles.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          childAspectRatio: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (widget. pickedfiles[index].name.contains('.mp4') ||
                          widget.  pickedfiles[index].name.endsWith('.mov')) {
                            return Card();
                          } else {
                            return buildImageElement(widget. pickedfiles[index]);
                          }
                        },
                      ),
                    );
  }
  
  void deleteFile(int index) {
    setState(() {
   widget.   pickedfiles.removeAt(index);
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
            onTap: () {
              int index =widget. pickedfiles.indexOf(image);
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

  // Widget buildVideoElement(File videoFile) {
  //   final VideoPlayerController videoController = VideoPlayerController.asset(
  //     'assets/video (2160p).mp4',
  //     videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
  //   )
  //     ..setLooping(true)
  //     ..initialize().then((_) {
  //       setState(() {});
  //     }).catchError((error) {
  //       print("Error initializing video: $error");
  //     });
  //   return Stack(
  //     children: [
  //       AspectRatio(
  //         aspectRatio: videoController.value.aspectRatio,
  //         child: VideoPlayer(videoController),
  //       ),
  //       Positioned(
  //         top: 8,
  //         left: 8,
  //         child: GestureDetector(
  //           onTap: () {
  //             int index = selectedImages.indexOf(videoFile);
  //             deleteFile(index);
  //           },
  //           child: const Icon(
  //             Icons.close,
  //             color: Colors.white,
  //             size: 24,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  
}
