import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class RepostedBy extends StatelessWidget {
  const RepostedBy(
      {super.key,
      required this.userId,
      required this.reposteruserid,
      required this.reposteruserName});
  final String userId;
  final String reposteruserid;
  final String reposteruserName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                id: reposteruserid,
                text: TempUser.id == userId ? '' : 'no',
              ),
            ),
          );
        } else {
          BlocProvider.of<SidebarCubit>(context).openProfile(
              reposteruserid, reposteruserid == TempUser.id ? '' : 'Following');
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 3, left: 25),
        child: Row(
          children: [
            const Icon(FontAwesomeIcons.retweet,
                size: 20, color: Color.fromARGB(255, 95, 94, 94)),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenWidth * 0.5),
              child: Text(
                maxLines: 1,
                '  ${reposteruserName}',
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 95, 94, 94)),
              ),
            ),
            const Text(
              maxLines: 1,
              ' reposted',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 95, 94, 94)),
            ),
          ],
        ),
      ),
    );
  }
}
