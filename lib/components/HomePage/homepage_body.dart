import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/components/HomePage/WebComponents/add_post.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
        userImage: 'assets/girl.jpg',
        image: 'assets/nature.jpeg',
        userName: 'Menna Ahmed',
        userHandle: 'MennaAhmed71',
        time: '4h',
        tweetText:
            'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '),
    Tweet(
        userImage: 'assets/girl.jpg',
        image: 'assets/nature.jpeg',
        userName: 'Menna Ahmed',
        userHandle: 'MennaAhmed71',
        time: '4h',
        tweetText:
            'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '),
    Tweet(
        userImage: 'assets/girl.jpg',
        image: 'assets/nature.jpeg',
        userName: 'Menna Ahmed',
        userHandle: 'MennaAhmed71',
        time: '4h',
        tweetText:
            'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '),
    Tweet(
        userImage: 'assets/girl.jpg',
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
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: kIsWeb
                  ? AddPost()
                  : Container(
                      height: 0,
                      width: 0,
                    ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(childCount: tweets.length,
                  (BuildContext context, int index) {
                return CustomTweet(
                  tweet: tweets[index],
                );
              }),
            ),
          ],
        ),
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: kIsWeb
                  ? AddPost()
                  : Container(
                      height: 0,
                      width: 0,
                    ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(childCount: tweets.length,
                    (BuildContext context, int index) {
              return Icon(Icons.directions_transit, size: 350);
            }))
          ],
        )
      ],
    );
  }
}
