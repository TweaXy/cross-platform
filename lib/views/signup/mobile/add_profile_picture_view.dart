import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/views/signup/mobile/add_username_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/shared/keys/sign_up_keys.dart';

class AddProfilePictureView extends StatefulWidget {
  const AddProfilePictureView({
    super.key,
  });

  @override
  State<AddProfilePictureView> createState() => _AddProfilePictureViewState();
}

class _AddProfilePictureViewState extends State<AddProfilePictureView> {
  XFile? image, imageTemporary;
  bool isButtonEnabled = false;

  Future pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    try {
      imageTemporary = await picker.pickImage(source: source);
      if (imageTemporary != null) {
        imageTemporary = await _cropImage();
      }

      setState(() {
        image = imageTemporary;
        isButtonEnabled = true;
      });
    } catch (e) {
      setState(() {
        image = null;
        isButtonEnabled = false;
      });
    }
  }

  Future<XFile?> _cropImage() async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: imageTemporary!.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            showCropGrid: false,
            hideBottomControls: true,
            cropFrameColor: Colors.transparent,
            toolbarTitle: 'Move and Scale',
            backgroundColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
      ],
      cropStyle: CropStyle.circle,
    );

    if (cropped != null) {
      return XFile(cropped.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        key: ValueKey("AddProfilePictureAppbar"),
        iconButton: null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.78,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01),
                      child: CustomHeadText(
                        textValue: "Pick a profile picture",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.03),
                      child: CustomParagraphText(
                          textValue: "Have a favourite selfie? Upload it now.",
                          textAlign: TextAlign.left),
                    ),
                    Center(
                      child: image != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(File(image!.path)),
                            )
                          : GestureDetector(
                              key: const ValueKey(
                                  SignUpKeys.addProfilePicLoadButtonKey),
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return customizedSimpleDialog();
                                    });
                                // await pickImage();
                              },
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                color: Colors.blue,
                                dashPattern: const [6],
                                strokeWidth: 2,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 40),
                                radius: const Radius.circular(12),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.blue,
                                      size: 50,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 5.0, left: 3.0),
                                      child: Text(
                                        "Upload",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        key: const ValueKey(
                            SignUpKeys.addProfilePicSkipButtonKey),
                        color: backgroundColorTheme(context),
                        text: "Skip for now",
                        onPressedCallback: () {
                          //make the image the default image first
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: const AddUsernameView()));
                        },
                        initialEnabled: true,
                      ),
                      CustomButton(
                        key: const ValueKey("addProfilePicsNextButton"),
                        color: forgroundColorTheme(context),
                        text: "Next",
                        onPressedCallback: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: const AddUsernameView()));
                        },
                        initialEnabled: isButtonEnabled,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  customizedSimpleDialog() {
    return SimpleDialog(
      contentPadding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.1, top: 15, bottom: 15),
      insetPadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
      children: <Widget>[
        SimpleDialogOption(
          key: const ValueKey("addProfilePicCameraOption"),
          onPressed: () {
            Navigator.pop(context, pickImage(source: ImageSource.camera));
          },
          child: const Text(
            'Take photo',
            style: TextStyle(fontSize: 17.0),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        SimpleDialogOption(
          key: const ValueKey("addProfilePicGalleryOption"),
          onPressed: () {
            Navigator.pop(context, pickImage(source: ImageSource.gallery));
          },
          child: const Text(
            'Choose existing photo',
            style: TextStyle(fontSize: 17.0),
          ),
        ),
      ],
    );
  }
}
