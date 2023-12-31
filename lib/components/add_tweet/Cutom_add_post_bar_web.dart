import 'package:flutter/material.dart';
import 'package:tweaxy/components/add_tweet/Custom_add_images_iconbutton.dart';
import 'package:tweaxy/components/add_tweet/custom_post_button_web.dart';
import 'package:tweaxy/components/custom_circular_progress_indicator.dart';

class CustomAddPostBarWeb extends StatelessWidget {
  const CustomAddPostBarWeb(
      {super.key,
      required this.addTweetController,
      required this.getImage,
      required this.postbuttonenabled,
      required this.postbuttonpress});
  final Function getImage;
  final TextEditingController addTweetController;
  final bool postbuttonenabled;
  final Function postbuttonpress;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomAddImageIconButton(
          getImage: getImage,
        ),
        Row(
          children: [
            if (addTweetController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CusotmCircularProgressIndicator(
                    tweetController: addTweetController),
              ),
            CustomPostButtonWeb(
              isButtonEnabled: postbuttonenabled,
              onpress: postbuttonpress,
            ),
          ],
        ),
      ],
    );
  }
}
