import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/views/profile/profile_screen.dart';

class UserImageForTweet extends StatelessWidget {
  const UserImageForTweet(
      {super.key,
      required this.image,
      required this.userid,
      required this.text});
  final String userid;
  final String image;
  final String text;
  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                id: userid,
                text: text,
              ),
            ),
          );
        }
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Image(
            width: 37,
            image: CachedNetworkImageProvider(
              image == null
                  ? "https://www.gstatic.com/webp/gallery2/4.png"
                  : 'http://16.171.65.142:3000/$image',
            ),
          )),
    );
  }
}
