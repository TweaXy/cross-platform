import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({
    super.key,
    required this.profileName,
    required this.userName,
    required this.followers,
    required this.following,
    required this.bio,
    required this.joinedDate,
    required this.location,
    required this.birthDate,
  });
  final String profileName;
  final String userName;
  final int followers;
  final int following;
  final String bio;
  final String joinedDate;
  final String birthDate;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250,
            child: Row(
              children: [
                Text(
                  profileName,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SizedBox(
              width: 250,
              child: Text(
                '@$userName',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey[700],
                ),
              ),
            ),
          ),
          bio!=''?Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 5 / 6,
              child: Linkify(
                text: bio,
                style: const TextStyle(color: Colors.black87),
                onOpen: (link) async {
                  if (!await launchUrl(Uri.parse(link.url))) {
                    throw Exception('Could not launch ${link.url}');
                  }
                },
              ),
            ),
          ):const SizedBox(),
          Row(children: [
            AccountJoinedDateBar(joinedDate: joinedDate),
            location != ''
                ? AccountLocationBar(location: location)
                : const SizedBox(),
          ]),
          
          AccountBirthdateBar(birthDate: birthDate),
          FollowingAndFollowersBar(following: following, followers: followers)
        ],
      ),
    );
  }
}

class AccountBirthdateBar extends StatelessWidget {
  const AccountBirthdateBar({
    super.key,
    required this.birthDate,
  });

  final String birthDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_month_outlined,
          color: Colors.blueGrey[700],
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            'Born ${DateFormat.yMMMM().format(DateTime.parse(birthDate))}',
            style: TextStyle(
              color: Colors.blueGrey[700],
            ),
          ),
        ),
      ],
    );
  }
}

class FollowingAndFollowersBar extends StatelessWidget {
  const FollowingAndFollowersBar({
    super.key,
    required this.following,
    required this.followers,
  });

  final int following;
  final int followers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Text(
            NumberFormat.compact().format(following),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          Text(
            ' Following   ',
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Colors.blueGrey[700],
              fontSize: 15,
            ),
          ),
          Text(
            NumberFormat.compact().format(followers),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          Text(
            ' Followers',
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Colors.blueGrey[700],
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountJoinedDateBar extends StatelessWidget {
  const AccountJoinedDateBar({
    super.key,
    required this.joinedDate,
  });

  final String joinedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_month_outlined,
          color: Colors.blueGrey[700],
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            'Joined ${DateFormat.yMMMM().format(DateTime.parse(joinedDate))}',
            style: TextStyle(
              color: Colors.blueGrey[700],
            ),
          ),
        ),
      ],
    );
  }
}

class AccountLocationBar extends StatelessWidget {
  const AccountLocationBar({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: Colors.blueGrey[700],
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Text(
            location,
            style: TextStyle(
              color: Colors.blueGrey[700],
            ),
          ),
        ),
      ],
    );
  }
}
