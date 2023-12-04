import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:tweaxy/services/Tweets.dart';

class LikersProfileView extends StatelessWidget {
  const LikersProfileView({super.key, required this.controller});
  final ScrollController controller;
  List<Tweet> initializeTweets(List<Map<String, dynamic>> temp) {
    // print('hhh' + temp.toString());
    return temp
        .map((e) => Tweet(
              id: e['id']!,
              image: e['image'],
              userImage: e['userImage']!,
              userHandle: e['userHandle']!,
              userName: e['userName']!,
              time: e['time']!,
              tweetText: e['tweetText'],
              userId: e['userid'],
              likesCount: 1,
              viewsCount: 1,
              retweetsCount: 1,
              commentsCount: 1,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Tweets.getTweetsHome(scroll: controller),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError || snapshot.hasError) {
            return const SliverToBoxAdapter(
              child:  Center(
                heightFactor: 3,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          } else {
            List<Map<String, dynamic>> s = snapshot.data!;
            // print(s);
            List<Tweet> tweets = initializeTweets(s);
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CustomTweet(
                    forProfile: true,
                    tweet: tweets[index],
                  );
                },
                childCount: snapshot.data!.length,
              ),
            );
           
          }
        });
  }
}
