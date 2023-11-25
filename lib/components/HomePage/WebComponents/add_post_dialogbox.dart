import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/Components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/Components/custom_appbar_web.dart';

class AddPostDialogBox extends StatefulWidget {
  const AddPostDialogBox({super.key});

  @override
  State<AddPostDialogBox> createState() => _AddPostDialogBoxState();
}

class _AddPostDialogBoxState extends State<AddPostDialogBox> {
  double dialogHight = 0;
  XFile? image, imageTemporary;
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      imageTemporary = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = imageTemporary;
        dialogHight = MediaQuery.of(context).size.height * .7;
      });
    } catch (e) {
      setState(() {
        image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) dialogHight = MediaQuery.of(context).size.height * .3;

    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5, // Set width to maximum
        height: dialogHight,
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
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 0.2,
                            color: Theme.of(context).brightness ==
                                    Brightness.light
                                ? const Color.fromARGB(255, 135, 135, 135)
                                : const Color.fromARGB(255, 233, 233, 233))),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          UserImageForTweet(image: 'assets/girl.jpg'),
                          Expanded(
                            child: TextField(
                              maxLength: 30,
                              decoration: InputDecoration(
                                hintText: 'What is hapenning?!',
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
                          )
                        ],
                      ),
                      if (image != null)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .2,
                          child: Image.network(
                            image!.path, // Replace with your network image URL
                            fit: BoxFit
                                .contain, // Resize the image to fit the width while maintaining its aspect ratio
                          ),
                        ),
                      if (image != null)
                      SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                        Align(
                          heightFactor: 1,
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                splashRadius: 20,
                                hoverColor:
                                    const Color.fromARGB(255, 207, 232, 253),
                                icon: const Icon(FontAwesomeIcons.image),
                                color: Colors.blue.shade400,
                                iconSize: 17,
                                onPressed: () async {
                                  await pickImage();
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Post',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  elevation: 20,
                                  padding: EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
