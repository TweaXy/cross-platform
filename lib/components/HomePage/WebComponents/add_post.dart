import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/post_button.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 0.2,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 135, 135, 135)
                    : const Color.fromARGB(255, 233, 233, 233))),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              UserImageForTweet(image: 'uploads/default.png'),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'What is hapenning?!',
                    hintStyle: TextStyle(
                      fontSize: 20, // Customize the font size of the hint text
                      // Customize the font style of the hint text
                      // Add any other desired style properties here
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 32, horizontal: 10),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenwidth * 0.03, bottom: screenheight * 0.007),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 20,
                  hoverColor: const Color.fromARGB(255, 207, 232, 253),
                  icon: const Icon(FontAwesomeIcons.image),
                  color: Colors.blue.shade400,
                  iconSize: 17,
                  onPressed: () {},
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Post',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                // IconButton(
                //   icon: Icon(FontAwesomeIcons.faceSmile),
                //   color: Colors.blue.shade400,
                //   iconSize: 17,
                //   onPressed: () {},
                // ),
                // Material(
                //   child: Ink(
                //     decoration: ShapeDecoration(
                //       shape: RoundedRectangleBorder(
                //         side: BorderSide(
                //           color: Colors.blue.shade400,
                //         ),
                //         borderRadius: BorderRadius.circular(4.0),
                //       ),
                //     ),
                //     child: IconButton(
                //       padding: EdgeInsets.zero,
                //       constraints: BoxConstraints(),
                //       icon: Icon(Icons.gif),
                //       color: Colors.blue.shade400,
                //       iconSize: 20,
                //       onPressed: () {},
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
