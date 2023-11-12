import 'package:flutter/material.dart';

class UserImageForTweet extends StatelessWidget {
  const UserImageForTweet({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: Image(
          width: 50,
          image: AssetImage(image),
        ));
  }
}
