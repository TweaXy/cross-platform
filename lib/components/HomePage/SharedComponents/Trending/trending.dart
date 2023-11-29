import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/models/trending_model.dart';

class Trending extends StatelessWidget {
  const Trending({super.key, required this.trend});
  final TrendingModel trend;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.009),

        //     textStyle: TextStyle(fontSize: 14)
        //     // splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () {},
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.009),
          margin: EdgeInsets.symmetric(vertical: screenWidth * 0.001),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  trend.trendingText,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color.fromARGB(255, 150, 150, 150)
                        : Colors.white,
                  ),
                ),
                const Icon(
                  FontAwesomeIcons.ellipsis,
                  size: 15,
                )
              ]),
              SizedBox(
                height: screenHeight * 0.007,
              ),
              Text(
                '#${trend.trendingHashtag}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.007,
              ),
              Text(
                '${trend.numberOfPosts} posts',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(255, 150, 150, 150)
                      : Colors.white,
                ),
              )
            ],
          )),
    );
  }
}
