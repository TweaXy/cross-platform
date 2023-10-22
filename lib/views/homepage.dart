import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/AppBar/appBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: IconButton(
                onPressed: () {
                  //refresh
                },
                icon: Icon(
                  FontAwesomeIcons.xTwitter,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  //swipe left
                },
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
            SliverToBoxAdapter(child: ApplicationBar()),

            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 900,
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
