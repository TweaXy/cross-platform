import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class AddProfilePictureWebView extends StatelessWidget {
  const AddProfilePictureWebView({super.key});

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
                      child: Stack(alignment: Alignment.center, children: [
                        // Image.asset(
                        //   "assets/images/addProfilePicWeb.jpg",

                        // ),
                        //TODO Choose a photo with no background
                        MaterialButton(
                          onPressed: () {
                            //TODO handle image upload
                          },
                          color: Colors.transparent,
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(20),
                          shape: CircleBorder(),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: CustomButton(
                  key: const ValueKey("addUsernameWebSkipButton"),
                  color: backgroundColorTheme(context),
                  text: "Skip for now",
                  onPressedCallback: () {
                    //TODO handle navigation
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
