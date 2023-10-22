import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/below_appBar.dart';

class ApplicationBar extends StatefulWidget {
  const ApplicationBar({Key? key}) : super(key: key);

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();
}

class _ApplicationBarState extends State<ApplicationBar> {
  // bool isVisible = true;
  // ScrollController? controller;
  // @override
  // void initState() {
  //   controller = ScrollController();
  //   controller.addListener(() {setState(() {
  //     isVisible=controller.position.userScrollDirection==ScrollDirection.forward;
  //   });})
  // }

  Widget build(BuildContext context) {
    return BelowAppBar();
    // CustomScrollView(slivers: [
    //   AppBar(
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //     centerTitle: true,
    //     title: IconButton(
    //       onPressed: () {},
    //       icon: Icon(
    //         FontAwesomeIcons.xTwitter,
    //         size: 30,
    //         color: Colors.black,
    //       ),
    //     ),
    //     leading: IconButton(
    //       onPressed: () {},
    //       icon: Icon(
    //         FontAwesomeIcons.user,
    //         size: 25,
    //         color: Colors.black,
    //       ),
    //     ),
    //   )
    // ]);
  }
}
