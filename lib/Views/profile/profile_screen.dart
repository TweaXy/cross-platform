import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  int _selectedTabIndex = 0;
  var listitems = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
    'item6',
    'item7',
    'item8',
    'item9',
    'item10',
    'item11',
    'item12',
    'item13',
    'item14',
    'item15',
    'item16',
    'item18',
    'item19',
    'item20'
  ];
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ProfileScreenAppBar(),
            ),
            SliverToBoxAdapter(
              child: Padding(
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
                            'Ahmed Samy',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child:
                                SvgPicture.asset('assets/images/verified.svg'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        '@ahmedsamy',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[700],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 5 / 6,
                        child: Linkify(
                          text:
                              'If there\'s no problem then there\'s a problem\nLink 1:- http://google.com\nLink2:- http://facebook.com',
                          style: const TextStyle(color: Colors.black87),
                          onOpen: (link) async {
                            if (!await launchUrl(Uri.parse(link.url))) {
                              throw Exception('Could not launch ${link.url}');
                            }
                          },
                        ),
                      ),
                    ),
                    Row(children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.blueGrey[700],
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Joined ' +
                              DateFormat.yMMMM()
                                  .format(DateTime.parse('2023-08-27')),
                          style: TextStyle(
                            color: Colors.blueGrey[700],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.blueGrey[700],
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          'Egypt',
                          style: TextStyle(
                            color: Colors.blueGrey[700],
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          Text(
                            NumberFormat.compact().format(32500),
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
                            NumberFormat.compact().format(24505000),
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
                    )
                  ],
                ),
              ),
            ),
            SliverTabBar(
              expandedHeight: 0,
              backgroundColor: Colors.transparent,
              tabBar: TabBar(
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                labelColor: Colors.black,
                onTap: (value) => setState(() {
                  _selectedTabIndex = value;
                }),
                tabs: const [
                  Tab(
                    text: 'Posts',
                  ),
                  Tab(
                    text: 'Replies',
                  ),
                  Tab(
                    text: 'Likes',
                  )
                ],
              ),
            ),
            SliverList.builder(
              itemCount: listitems.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      title: Text(listitems[index].toString() +
                          _selectedTabIndex.toString()),
                      tileColor: Colors.white,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreenAppBar extends SliverPersistentHeaderDelegate {
  final bottomHeight = 60;
  final extraRadius = 5;
  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final imageTop =
        -shrinkOffset.clamp(0.0, maxExtent - minExtent - bottomHeight);

    final double clowsingRate = (shrinkOffset == 0
            ? 0.0
            : (shrinkOffset / (maxExtent - minExtent - bottomHeight)))
        .clamp(0, 1);

    final double opacity = shrinkOffset == minExtent
        ? 0
        : 1 - (shrinkOffset.clamp(minExtent, minExtent + 30) - minExtent) / 30;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 20,
          left: 45,
          child: Row(
            children: [
              Transform.scale(
                scale: 1.9 - clowsingRate,
                alignment: Alignment.bottomCenter,
                child: const _Avatar(),
              ),
              const Spacer(),
              FollowEditButton(onPressed: () {}, text: 'UnFollow'),
            ],
          ),
        ),
        _banner(
            imageTop: imageTop,
            clowsingRate: clowsingRate,
            bottomHeight: bottomHeight,
            extraRadius: extraRadius,
            maxExtent: maxExtent,
            opacity: opacity),
        Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            child: Row(
              children: [
                _IconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {},
                ),
                Spacer(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: _IconButton(
                        icon: Icons.search,
                        onPressed: () {},
                      ),
                    ),
                    _IconButton(
                      icon: Icons.more_vert,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class FollowEditButton extends StatelessWidget {
  const FollowEditButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: text == 'Follow' ? Colors.white : Colors.black,
          fontSize: 17,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
            text == 'Follow' ? Colors.black : Colors.white),
        minimumSize: MaterialStatePropertyAll<Size>(Size(90, 35)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class _banner extends StatelessWidget {
  const _banner({
    super.key,
    required this.imageTop,
    required this.clowsingRate,
    required this.bottomHeight,
    required this.extraRadius,
    required this.maxExtent,
    required this.opacity,
  });

  final double imageTop;
  final double clowsingRate;
  final int bottomHeight;
  final int extraRadius;
  final double maxExtent;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: imageTop,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: InvertedCircleClipper(
          radius: (1.9 - clowsingRate) * bottomHeight / 2 + extraRadius,
          offset: Offset(
            bottomHeight / 2 + 45,
            (maxExtent - bottomHeight + extraRadius / 2) +
                clowsingRate * bottomHeight / 2,
          ),
        ),
        child: SizedBox(
          height: maxExtent - bottomHeight,
          child: ColoredBox(
            color: Colors.white,
            child: Blur(
              blur: 15 * clowsingRate,
              blurColor: Colors.black,
              colorOpacity: clowsingRate / 4,
              child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl:
                      "https://www.kasandbox.org/programming-images/avatars/mr-pants-purple.png",
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 5,
                        )),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onPressed,
  });
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(4),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: const Text(
        'Follow',
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  const InvertedCircleClipper({
    required this.offset,
    required this.radius,
  });
  final Offset offset;
  final double radius;

  @override
  Path getClip(size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: offset,
        radius: radius,
      ))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class _Avatar extends StatelessWidget {
  const _Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl:
              "https://www.kasandbox.org/programming-images/avatars/spunky-sam.png",
          placeholder: (context, url) => const Center(
            child: SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 5,
                )),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
