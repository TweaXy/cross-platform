import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/components/HomePage/WebComponents/add_post.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/services/tweets_services.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody(
      {super.key, required this.tabController, required this.controller});
  final TabController tabController;
  final ScrollController controller;
  final List<Map<String, String>> temp = const [
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '1',
      'userid': '1',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    },
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '2',
      'userid': '2',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    },
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '3',
      'userid': '3',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    },
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '4',
      'userid': '4',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    },
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '5',
      'userid': '5',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    }
  ];
  List<Tweet> initializeTweets(List<Map<String, dynamic>> temp) {
    // print('hhh' + temp.toString());
    return temp
        .map((e) => Tweet(
              id: e['id']!,
              image: _getImageList(e['image']),
              userImage: e['userImage']!,
              userHandle: e['userHandle']!,
              userName: e['userName']!,
              time: e['time']!,
              tweetText: e['tweetText'],
              userId: e['userid'],
              likesCount: e['likesCount'],
              viewsCount: e['viewsCount'],
              retweetsCount: e['retweetsCount'],
              commentsCount: e['commentsCount'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TweetsServices.getTweetsHome(scroll: controller),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          // print('tt' + Tweets.getTweetsHome().toString());
          return const Scaffold(
            body: Column(
              children: [
                Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Column(
              children: [
                Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
              ],
            ),
          );
        } else {
          // print('tt' + Tweets.getTweetsHome().toString());

          // print('tw' + snapshot.data!.toString());
          List<Map<String, dynamic>> s = snapshot.data!;
          // print(s);
          List<Tweet> tweets = initializeTweets(s);

          // print(s);
          return TabBarView(
            controller: tabController,
            children: <Widget>[
              CustomScrollView(
                scrollBehavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                slivers: [
                  const SliverToBoxAdapter(
                    child: kIsWeb
                        ? AddPost()
                        : SizedBox(
                            height: 0,
                            width: 0,
                          ),
                  ),
                  SliverList(
                    delegate:
                        SliverChildBuilderDelegate(childCount: tweets.length,
                            (BuildContext context, int index) {
                      return CustomTweet(
                        forProfile: false,
                        tweet: tweets[index],
                      );
                    }),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}

List<String>? _getImageList(dynamic image) {
  if (image == null) {
    return null;
  } else if (image is String) {
    return [image];
  } else if (image is List<dynamic>) {
    print(image.map((item) => item.toString()).toList());
    // If 'image' is already a List, convert each item to String
    return image.map((item) => item.toString()).toList();
  } else {
    return null;
  }
}
