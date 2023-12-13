import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tweaxy/components/HomePage/floating_action_button.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/temp_user.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingButton(),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  floating: true,
                  pinned: true,
                  bottom: const TabBar(
                    indicatorWeight: 3,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 50),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                    isScrollable: false,
                    
                    tabs: <Widget>[
                      Tab(
                        text: 'All',
                      ),
                      Tab(
                        text: 'Mentions',
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  leading: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, kProfileScreen);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: CachedNetworkImageProvider(
                            basePhotosURL + TempUser.image),
                      ),
                    ),
                  ),
                  titleSpacing: 10,
                  title: const Text('Notifications'),
                  centerTitle: true,
                  titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
                  itemCount: 200,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/heart.svg',
                            width: 24,
                            height: 24,
                            color: Colors.pink,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return const Center(
                                      child: SpinKitRing(
                                        lineWidth: 3,
                                        size: 20,
                                        color: Colors.blueAccent,
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return const Icon(
                                      Icons.error_outline,
                                      color: Colors.blueAccent,
                                    );
                                  },
                                  imageUrl:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ5UwKCy7XSpAi4AlMyA5jUo1QFzcoT8DVfhVzV-0SicNd6e6yastjou-GUkcRaDa5M4U'),
                            ),
                          )
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                            left: 35.0, top: 15, bottom: 15, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              maxLines: 10,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Ahmed Samy',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' Liked Your Tweet a sfas fa sfas fas fas',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nThis is a new tweet \nI need a new tweet \nHello',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                ListView.separated(
                  itemBuilder: (context, index) {
                    return Placeholder();
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
                  itemCount: 200,
                ),
              ],
            ),
          ),
        ));
  }
}
