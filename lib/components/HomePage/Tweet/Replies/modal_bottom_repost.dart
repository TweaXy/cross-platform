// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';

// class ModalBottomRepost extends StatelessWidget {
//   const ModalBottomRepost(
//       {super.key, required this.repost, required this.tweetid});
//   final bool repost;
//   final String tweetid;
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: [
//         ListTile(
//           onTap: () {
//             if (repost) {
//               BlocProvider.of<TweetsUpdateCubit>(context).retweet(tweetid);
//             }
//             //call api of repost
//             else {
//               //call api of delete repost
//               BlocProvider.of<TweetsUpdateCubit>(context)
//                   .deleteretweet(tweetid);
//             }
//             Navigator.pop(context);
//           },
//           leading: Icon(FontAwesomeIcons.retweet),
//           title: Text(
//             repost ? 'Repost' : 'Undo Repost',
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ],
//     );
//   }
// }
