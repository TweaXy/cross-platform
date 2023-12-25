import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_layout/multi_image_layout.dart';
import 'package:video_player/video_player.dart';

class TweetMedia extends StatefulWidget {
  const TweetMedia({super.key, required this.pickedfiles});
  final List<String> pickedfiles;

  @override
  State<TweetMedia> createState() => _TweetMediaState();
}

//
class _TweetMediaState extends State<TweetMedia> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    List<String> s = widget.pickedfiles.map((item) => '').toList();

    return MultiImageViewer(
      images: widget.pickedfiles,
    );
    // return Container();
  }
}
