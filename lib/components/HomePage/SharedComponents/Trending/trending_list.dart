import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/Trending/trending.dart';
import 'package:tweaxy/models/trending_model.dart';

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
        decoration: BoxDecoration(
            color: Color(0xfff7f9f9), borderRadius: BorderRadius.circular(10)),
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
              child: Text(
                'What\'s Happening',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
