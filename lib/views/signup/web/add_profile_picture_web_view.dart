import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/views/signup/web/add_username_web_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/models/user_signup.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class AddProfilePictureWebView extends StatefulWidget {
  const AddProfilePictureWebView({super.key});

  @override
  State<AddProfilePictureWebView> createState() =>
      _AddProfilePictureWebViewState();
}

class _AddProfilePictureWebViewState extends State<AddProfilePictureWebView> {
  XFile? image, imageTemporary;
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      imageTemporary = await picker.pickImage(source: ImageSource.gallery);
      if (imageTemporary != null) {
        imageTemporary = await _cropImage();
      }
      setState(() {
        image = imageTemporary;
      });
    } catch (e) {
      setState(() {
        image = null;
      });
    }
  }

  Future<XFile?> _cropImage() async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: imageTemporary!.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        WebUiSettings(
          context: context,
          enableZoom: true,
          enableOrientation: false,
          customDialogBuilder: (cropper, crop, rotate) {
            return Dialog(
              backgroundColor: backgroundColorTheme(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: Builder(
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: MediaQuery.of(context).size.height * 0.065,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  padding: const EdgeInsets.only(top: 8),
                                  // iconSize: 20,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: forgroundColorTheme(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                      right: MediaQuery.of(context).size.width *
                                          0.23,
                                      top: 10),
                                  child: Text(
                                    "Edit Media",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: forgroundColorTheme(context),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final result = await crop();
                                      Navigator.of(context).pop(result);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.black, // Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "Apply",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: cropper),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );

    if (cropped != null) {
      return XFile(cropped.path);
    }
    return null;
  }

  SignupService service = SignupService(Dio());

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
                child: image == null
                    ? CustomButton(
                        key: const ValueKey("addUsernameWebSkipButton"),
                        color: backgroundColorTheme(context),
                        text: "Skip for now",
                        onPressedCallback: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => const AddUsernameWebView(),
                            barrierColor: Colors.transparent,
                            barrierDismissible: false,
                          );
                        },
                        initialEnabled: true,
                      )
                    : CustomButton(
                        key: const ValueKey("addUsernameWebNextButton"),
                        color: forgroundColorTheme(context),
                        text: "Next",
                        onPressedCallback: () async {
                          UserSignup.profilePicture = image!;
                          try {
                            dynamic response = await service.updateAvater();
                            if (response is String) {
                              showToastWidget(
                                CustomWebToast(
                                  message: response,
                                ),
                                position: ToastPosition.bottom,
                                duration: const Duration(seconds: 2),
                              );
                            } else if (mounted) {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const AddUsernameWebView(),
                                barrierColor: Colors.transparent,
                                barrierDismissible: false,
                              );
                            }
                          } catch (e) {
                            log(e.toString());
                          }
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
