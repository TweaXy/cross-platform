import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/Components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/Components/custom_appbar_web.dart';
import 'dart:io';
import 'package:tweaxy/Components/toasts/custom_web_toast.dart';

class AddPostDialogBox extends StatefulWidget {
  const AddPostDialogBox({super.key});

  @override
  State<AddPostDialogBox> createState() => _AddPostDialogBoxState();
}

class _AddPostDialogBoxState extends State<AddPostDialogBox> {
  List<File> selectedImages = [];
  List<String> selectedImagesstrings = []; // List of selected image
  final picker = ImagePicker();
  double dialogHight = 0;
  // XFile? image, imageTemporary;
  // Future pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   try {
  //     imageTemporary = await picker.pickImage(source: ImageSource.gallery);
  //     setState(() {
  //       image = imageTemporary;
  //       dialogHight = MediaQuery.of(context).size.height * 0.9;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       image = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (selectedImagesstrings.isEmpty) {
      setState(() {
        dialogHight = MediaQuery.of(context).size.height * .5;
      });
    }

    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5, // Set width to maximum
        height: dialogHight,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbarWeb(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_sharp)),
                ),
                 Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Row(
                          children: [
                        const  Align(alignment:Alignment.topLeft,  child:    UserImageForTweet(image: 'assets/girl.jpg')),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.005),
                                child:const TextField(
                                  maxLines: 7,
                                  maxLength: 280,
                                  decoration: InputDecoration(
                                    hintText: 'What is hapenning?!',
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 12),
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                          if (selectedImagesstrings.isNotEmpty)
                  SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Set width to maximum
                    height: selectedImagesstrings.isNotEmpty
                        ? MediaQuery.of(context).size.height * 0.4
                        : 0,
                    child: GridView.builder(
                      addRepaintBoundaries: false,
                      itemCount: selectedImages.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.network(
                              selectedImagesstrings[index],
                              width: double.infinity,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  selectedImagesstrings.removeAt(index);
                                  selectedImages.removeAt(index);
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                        // if (image != null)
                        //   SizedBox(
                        //     width: MediaQuery.of(context).size.width * .2,
                        //     height: MediaQuery.of(context).size.height * .2,
                        //     child: Image.network( image!.path, fit: BoxFit.contain, ),
                        //   ),
                        // if (image != null)
                        //   SizedBox(
                        //     height: MediaQuery.of(context).size.height * 0.2,
                        //   ),

                        // if (selectedImages.length > 4)
                        //   const CustomWebToast(
                        //       message: "you can add more than 4 images"),

                        // Container(
                        //   child: MultiImagePickerView(
                        //     initialContainerBuilder: (context, pickfunction) {
                        //       return IconButton(
                        //           splashRadius: 20,
                        //           hoverColor:
                        //               const Color.fromARGB(255, 207, 232, 253),
                        //           icon: const Icon(FontAwesomeIcons.image),
                        //           color: Colors.blue.shade400,
                        //           iconSize: 17,
                        //           onPressed: () {
                        //             pickfunction();
                        //           });
                        //     },
                        //     addMoreBuilder: (context, pickfunction) {
                        //       return IconButton(
                        //           splashRadius: 20,
                        //           hoverColor:
                        //               const Color.fromARGB(255, 207, 232, 253),
                        //           icon: const Icon(FontAwesomeIcons.image),
                        //           color: Colors.blue.shade400,
                        //           iconSize: 17,
                        //           onPressed: () {
                        //             pickfunction();
                        //           });
                        //     },
                        //     onChange: (list) {
                        //       debugPrint(list.toString());
                        //     },
                        //     controller: controller,
                        //   ),
                        // ),
                      ],
                    )),
              ],
            ),
          ),
          bottomSheet: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      hoverColor: const Color.fromARGB(255, 207, 232, 253),
                      icon: const Icon(FontAwesomeIcons.image),
                      color: Colors.blue.shade400,
                      iconSize: 17,
                      onPressed: () {
                        getImages();
                        // await pickImage();
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .2),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        elevation: 20,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text(
                        'Post',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 4, // To set quality of images
        maxHeight: MediaQuery.of(context).size.height *
            0.4, // To set maxheight of images that you want in your app
        maxWidth: MediaQuery.of(context).size.width *
            0.4); // To set maxheight of images that you want in your app
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      setState(() {
        dialogHight = MediaQuery.of(context).size.height * .8;
      });
      if (xfilePick.length <= 4) {
        for (var i = 0; i < xfilePick.length; i++) {
          selectedImages.add(File(xfilePick[i].path));
          selectedImagesstrings.add(selectedImages[i].path);
        }
      } else {
        selectedImagesstrings = [];
        setState(() {
          dialogHight = MediaQuery.of(context).size.height * .5;
        });
      }
    }
  }
}
