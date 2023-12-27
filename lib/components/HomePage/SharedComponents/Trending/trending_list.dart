import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/Trending/trending.dart';
import 'package:tweaxy/models/trending_model.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({Key? key}) : super(key: key);

  final List<TrendingModel> trendings = const [
    TrendingModel(
      trendingText: 'Trending in Egypt',
      trendingHashtag: 'abo_3beda',
      numberOfPosts: '127k',
    ),
    TrendingModel(
      trendingText: 'Trending in Egypt',
      trendingHashtag: 'abo_3beda',
      numberOfPosts: '127k',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        key: const ValueKey(HomePageKeys.trendingList),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0xfff7f9f9)
                : const Color(0xff16181c),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(screenWidth * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.009,
                  right: screenWidth * 0.009,
                  top: screenWidth * 0.009),
              child: const Text(
                'What\'s happening',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: trendings.length,
              itemBuilder: (BuildContext context, int index) {
                return Trending(trend: trendings[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
