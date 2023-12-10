import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/homepage_body.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/views/trends/tweets_trend_list.dart';

class ViewTrendTweets extends StatefulWidget {
  const ViewTrendTweets({super.key, required this.trendName});
  final String trendName;

  @override
  State<ViewTrendTweets> createState() => _ViewTrendTweetsState();
}

class _ViewTrendTweetsState extends State<ViewTrendTweets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.grey[300],
              height: 0.7,
            ),
          ),
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          titleSpacing: 10,
          title: GestureDetector(
            onTap: () {
              //Todo Add navigation to Search View
              Navigator.pushNamed(context, kSearchScreen);
            },
            child: Container(
              width: double.infinity,
              height: AppBar().preferredSize.height * 2 / 3,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('     ${widget.trendName}',
                      style: TextStyle(color: Colors.grey[500], fontSize: 15))),
            ),
          ),
        ),
        body: CustomScrollView(slivers: [TweetsListTrend()]));
  }
}
