// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
// import 'package:tweaxy/components/toasts/custom_toast.dart';
// import 'package:tweaxy/components/toasts/custom_web_toast.dart';
// import 'package:tweaxy/models/tweet.dart';
// import 'package:tweaxy/services/tweets_services.dart';
// import 'package:tweaxy/utilities/tweets_utilities.dart';

// class ProfilePosts extends StatelessWidget {
//   const ProfilePosts({super.key, required this.controller});
//   final ScrollController controller;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: TweetsServices.getTweetsHome(scroll: controller),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.hasError) {
//             // print('tt' + Tweets.getTweetsHome().toString());
//             return const Scaffold(
//               body: Column(
//                 children: [
//                   Center(
//                       child: CircularProgressIndicator(
//                     color: Colors.blue,
//                   )),
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return const Scaffold(
//               body: Column(
//                 children: [
//                   Center(
//                       child: CircularProgressIndicator(
//                     color: Colors.blue,
//                   )),
//                 ],
//               ),
//             );
//           } else if (snapshot.data == []) {
//             return const Scaffold(
//                 body: kIsWeb
//                     ? CustomWebToast(message: 'no tweets found')
//                     : CustomToast(message: 'no tweets found'));
//           } else {
//             // print('tt' + Tweets.getTweetsHome().toString());

//             // print('tw' + snapshot.data!.toString());
//             List<Map<String, dynamic>> s = snapshot.data!;
//             // print(s);
//             List<Tweet> tweets = initializeTweets(s);

//             return CustomScrollView(
//               scrollBehavior:
//                   ScrollConfiguration.of(context).copyWith(scrollbars: false),
//               slivers: [
//                 SliverList(
//                   delegate:
//                       SliverChildBuilderDelegate(childCount: tweets.length,
//                           (BuildContext context, int index) {
//                     return CustomTweet(
//                       forProfile: false,
//                       tweet: tweets[index],
//                     );
//                   }),
//                 ),
//               ],
//             );
//           }
//         });
//   }
// }
