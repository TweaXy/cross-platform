import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/temp_user.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});
  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  String id = '';
  String token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('id')!;
      token = prefs.getString('token')!;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black38,
            height: 0.7,
          ),
        ),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, kProfileScreen);
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage:
                  CachedNetworkImageProvider(basePhotosURL + TempUser.image),
            ),
          ),
        ),
        titleSpacing: 10,
        title: GestureDetector(
          onTap: () {
            //Todo Add navigation to Search View
            Navigator.pushNamed(context, kSearchScreen);
          },
          child: Container(
            width: double.infinity,
            height: AppBar().preferredSize.height * 2 / 3,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('      Search TweaXy',
                    style: TextStyle(color: Colors.grey[500], fontSize: 15))),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var postNumber =
              NumberFormat.compactCurrency(symbol: '').format(818546);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'Trending in Egypt',
              ),
              titleTextStyle: TextStyle(
                color: Colors.blueGrey[700],
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Gaza',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '$postNumber posts',
                    style: TextStyle(
                      color: Colors.blueGrey[500],
                      fontSize: 13,
                      // fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
