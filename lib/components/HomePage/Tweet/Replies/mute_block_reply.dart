import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';

class MuteBlockReply extends StatelessWidget {
  const MuteBlockReply(
      {super.key, required this.tweetid, required this.isMute});
  final String tweetid;
  final bool isMute;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(255, 201, 200, 200),
            ),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  isMute
                      ? 'This Post is from an \naccount you muted.'
                      : 'This Post is from an \naccount you blocked.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 69, 68, 68),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Column(
              children: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<TweetsUpdateCubit>(context)
                          .showTweet(tweetid);
                    },
                    child: Text(
                      'View',
                      style: TextStyle(
                        fontSize: 21,
                        color: Color.fromARGB(255, 108, 108, 108),
                        fontWeight: FontWeight.w700,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
