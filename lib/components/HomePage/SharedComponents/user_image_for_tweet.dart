import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class UserImageForTweet extends StatelessWidget {
  const UserImageForTweet(
      {super.key,
      required this.image,
      required this.userid,
      required this.text});
  final String userid;
  final String image;
  final String text;
  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                id: userid,
                text: text,
              ),
            ),
          );
        } else {
          BlocProvider.of<SidebarCubit>(context)
              .openProfile(userid, userid == TempUser.id ? '' : 'Following');
        }
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Image(
            width: 45,
            image: CachedNetworkImageProvider(
              image == null
                  ? "https://tweaxybackend.mywire.org/api/v1/images/b631858bdaafa77258b9ed2f7c689bdb.png"
                  : 'https://tweaxybackend.mywire.org/api/v1/images/$image',
            ),
          )),
    );
  }
}
