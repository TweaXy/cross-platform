import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class AddProfilePictureView extends StatefulWidget {
  AddProfilePictureView({
    super.key,
  });

  @override
  State<AddProfilePictureView> createState() => _AddProfilePictureViewState();
}

class _AddProfilePictureViewState extends State<AddProfilePictureView> {
  TextEditingController myController = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    myController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = myController.text.isNotEmpty;
      //should be changed to image upload
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: const CustomAppbar(
              iconButton: null,
            ),
          ),
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
                    child: const CustomHeadText(
                      textValue: "Pick a profile picture",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: const CustomParagraphText(
                        textValue: "Have a favourite selfie? Upload it now.",
                        textAlign: TextAlign.left),
                  ),
                  Center(
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: Colors.blue,
                      dashPattern: [6],
                      strokeWidth: 2,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 40),
                      radius: const Radius.circular(12),
                      child: GestureDetector(
                        onTap: () {
                          //Upload the photo
                        },
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                              size: 50,
                            ),
                            Text(
                              "Upload",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      color: backgroundColorTheme(context),
                      text: "Skip for now",
                      onPressedCallback: () {},
                      initialEnabled: true,
                    ),
                    CustomButton(
                      color: forgroundColorTheme(context),
                      text: "Next",
                      onPressedCallback: () {},
                      initialEnabled: isButtonEnabled,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
