import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/Views/signup/web/add_username_web_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class AddProfilePictureWebView extends StatefulWidget {
  const AddProfilePictureWebView({super.key});

  @override
  State<AddProfilePictureWebView> createState() =>
      _AddProfilePictureWebViewState();
}

class _AddProfilePictureWebViewState extends State<AddProfilePictureWebView> {
  XFile? image;
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? imageTemporary =
          await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = imageTemporary;
      });
    } catch (e) {
      setState(() {
        image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColorTheme(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height * 0.1,
                child: const CustomAppbar(
                  key: ValueKey("addUsernameWebAppbar"),
                  iconButton: null,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeadText(
                      textValue: "Pick a profile picture",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02),
                      child: CustomParagraphText(
                          textValue: "Have a favourite selfie? Upload it now.",
                          textAlign: TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02),
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          image != null
                              ? CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(image!.path),
                                )
                              : const Icon(
                                  Icons.account_circle,
                                  size: 200,
                                  color: Color(0xFF8d949a),
                                ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Tooltip(
                                message: 'Add photo',
                                child: MaterialButton(
                                  key: const ValueKey("uploadProfilePicButton"),
                                  onPressed: () async {
                                    await pickImage();
                                  },
                                  color: const Color.fromRGBO(38, 47, 53, 150),
                                  padding: const EdgeInsets.all(20),
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    color: Colors.white,
                                    Icons.add_a_photo_outlined,
                                    size: 25,
                                  ),
                                ),
                              ),
                              image != null
                                  ? Tooltip(
                                      message: 'Cancel',
                                      child: MaterialButton(
                                        key: const ValueKey(
                                            "cancelProfilePicButton"),
                                        onPressed: () {
                                          setState(() {
                                            image = null;
                                          });
                                        },
                                        color: const Color.fromRGBO(
                                            38, 47, 53, 100),
                                        padding: const EdgeInsets.all(20),
                                        shape: const CircleBorder(),
                                        child: const Icon(
                                          color: Colors.white,
                                          Icons.close_sharp,
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: CustomButton(
                  key: const ValueKey("addUsernameWebSkipButton"),
                  color: image == null
                      ? backgroundColorTheme(context)
                      : forgroundColorTheme(context),
                  text: image == null ? "Skip for now" : "Next",
                  onPressedCallback: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddUsernameWebView(),
                      barrierColor: Colors.transparent,
                      barrierDismissible: false,
                    );
                  },
                  initialEnabled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
