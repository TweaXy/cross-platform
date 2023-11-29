import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImageForTweet extends StatelessWidget {
  const UserImageForTweet({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: Image(
          width: 37,
          image: CachedNetworkImageProvider(
            image == null
                ? "https://www.gstatic.com/webp/gallery2/4.png"
                : 'http://16.171.65.142:3000/$image',
          ),
        ));
  }
}
