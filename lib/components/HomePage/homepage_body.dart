import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/models/tweet.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key, required this.tabController});
  final TabController tabController;

  final List<Tweet> tweets = const [
    Tweet(
        userImage: 'assets/girl.jpg',
        image: 'assets/nature.jpeg',
        userName: 'Menna Ahmed',
        userHandle: 'MennaAhmed71',
        time: '4h',
        tweetText:
            'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '),
    Tweet(
        userImage: 'assets/logo2.ico',
        image: 'assets/nature.jpeg',
        userName: 'Menna Ahmed',
        userHandle: 'MennaAhmed71',
        time: '4h',
        tweetText:
            'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '),
    Tweet(
        userImage: 'assets/logo2.ico',
        image: 'assets/nature.jpeg',
        userName: 'Menna Ahmed',
        userHandle: 'MennaAhmed71',
        time: '4h',
        tweetText:
            'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '),
    Tweet(
        userImage: 'assets/logo2.ico',
        image: 'assets/nature.jpeg',
        userName: 'Menna Ahmed',
        userHandle: 'MennaAhmed71',
        time: '4h',
        tweetText:
            'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '),
    Tweet(
        userImage: 'assets/logo2.ico',
        image: 'assets/nature.jpeg',
        userName: 'Menna Ahmed',
        userHandle: 'MennaAhmed71',
        time: '4h',
        tweetText:
            'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '),
  ];
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        ListView.builder(
          itemCount: tweets.length,
          itemBuilder: (context, index) {
            return CustomTweet(
              tweet: tweets[index],
            );
          },
        ),
        ListView.builder(
          itemCount: tweets.length,
          itemBuilder: (context, index) {
            return Icon(Icons.directions_transit, size: 350);
          },
        ),
      ],
    );
  }
}
