import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/account_information.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/profile_icon_button.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/get_user_by_id.dart';
import 'package:tweaxy/views/profile/edit_profile_screen.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class ProfileComponentWeb extends StatefulWidget {
  const ProfileComponentWeb({super.key, required this.id});
  final String id;
  @override
  State<ProfileComponentWeb> createState() => _ProfileComponentWebState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _ProfileComponentWebState extends State<ProfileComponentWeb>
    with SingleTickerProviderStateMixin {
  bool hoverd = false;
  String text = 'Edit Profile';
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    GetUserById.instance.excute(widget.id);
  }

  int _selectedTabIndex = 0;

  Color textColor = Colors.black;
  Color buttonColor = Colors.black;
  double borderWidth = 0;
  Color borderColor = Colors.black;
  String profileName = 'Ahmed Samy';
  int postsNumber = 678530;
  final bio =
      'If there\'s no problem then there\'s a problem\nLink 1:- http://google.com\nLink2:- http://facebook.com';
  void Function() onPressed = () {};
  int? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetUserById.instance.future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            color: Colors.blue,
          )));
        } else {
          var user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              title: CollapsedAppBarText(
                profileNameTextColor: Colors.black,
                postsNumberTextColor: Colors.grey,
                postsNumberTextStyle: FontWeight.normal,
                postsNumber: postsNumber,
                profileName: user.name!,
                postsNumberTextSize: 14,
                profileNameTextSize: 21,
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            height: 200,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: user.cover ??
                                  "https://socialsizes.io/static/facebook-cover-photo-size-b4dd6123feb0ded4531a05cbd0bccd30.jpg",
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                      strokeWidth: 5,
                                    )),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                text == 'Following'
                                    ? Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: PopupMenuButton<int>(
                                              icon: const Icon(
                                                  Icons.more_horiz_outlined),
                                              offset: const Offset(-180, 0),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              initialValue: selectedMenu,
                                              // Callback that sets the selected popup menu item.
                                              onSelected: (item) {
                                                setState(() {
                                                  selectedMenu = item;
                                                });
                                              },
                                              itemBuilder:
                                                  (BuildContext context) => [
                                                _popupMenu(
                                                    0,
                                                    Icons.link_outlined,
                                                    'Copy link to profile'),
                                                _popupMenu(
                                                    1,
                                                    Icons.volume_off_outlined,
                                                    'Mute ${user.userName}'),
                                                _popupMenu(
                                                    2,
                                                    Icons.block_outlined,
                                                    'Block ${user.userName}'),
                                                _popupMenu(
                                                    3,
                                                    Icons.outlined_flag,
                                                    'Report ${user.userName}'),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: ProfileIconButton(
                                                borderWidth: 1,
                                                icon: Icons.mail_outline,
                                                onPressed: () {},
                                                color: Colors.white,
                                                iconColor: Colors.black),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: ProfileIconButton(
                                                borderWidth: 1,
                                                icon: Icons
                                                    .notification_add_outlined,
                                                onPressed: () {},
                                                color: Colors.white,
                                                iconColor: Colors.black),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                _followEditButton(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 7.5,
                        left: 15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                backgroundImage: CachedNetworkImageProvider(
                                  user.avatar ==null
                                      ? "https://www.gstatic.com/webp/gallery2/4.png"
                                      : '$basePhotosURL${user.avatar}',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: AccountInformation(
                    bio: user.bio ?? '',
                    followers: user.followers ?? 24870,
                    following: user.following ?? 230,
                    joinedDate: user.joinedDate ?? '2023-10-05',
                    location: user.location ?? '',
                    profileName: user.name ?? '',
                    birthDate: user.birthdayDate ?? '2002-08-27',
                    userName: user.userName ?? '',
                  ),
                ),
                SliverAppBar(
                  pinned: false,
                  toolbarHeight: 5,
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    labelColor: Colors.black,
                    controller: _tabController,
                    indicator: const UnderlineTabIndicator(
                        insets: EdgeInsets.symmetric(horizontal: 50),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 5,
                        )),
                    indicatorWeight: 5,
                    onTap: (value) {
                      _selectedTabIndex = value;
                      _tabController.animateTo(_selectedTabIndex);
                      setState(() {});
                    },
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
          );
        }
      },
    );
  }

  PopupMenuItem<int> _popupMenu(int value, IconData icon, String text) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _followEditButton() {
    if (text == 'Follow') {
      textColor = Colors.white;
      buttonColor = Colors.black;
      borderWidth = 0;
      borderColor = Colors.transparent;
      onPressed = () {
        text = 'Following';
        //TODO:- Implement the follow logic
        setState(() {});
      };
    } else if (text == 'Edit Profile') {
      textColor = Colors.black;
      buttonColor = Colors.white;
      if (hoverd) {
        buttonColor = kGreyHoveredColor;
      }
      borderWidth = 0.4;
      borderColor = Colors.grey;
      onPressed = () {
        //TODO:- Implement the edit profile logic
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white),
            ),
            content: SizedBox(
              width: 500,
              height: 700,
              child: EditProfileScreen(),
            ),
          ),
        );
      };
    } else {
      onPressed = () {
        text = 'Follow';
        //TODO:- Implement the unfollow logic
        setState(() {});
      };
      if (hoverd) {
        text = 'Unfollow';
        textColor = Colors.redAccent;
        buttonColor = const Color.fromARGB(40, 255, 82, 82);
        borderWidth = 0.4;
        borderColor = Colors.redAccent;
      } else {
        text = 'Following';
        textColor = Colors.black;
        buttonColor = Colors.white;
        borderWidth = 0.4;
        borderColor = Colors.grey;
      }
    }
    return ElevatedButton(
      onPressed: onPressed,
      onHover: (value) {
        setState(() {
          hoverd = value;
        });
      },
      style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size.fromHeight(35)),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: borderColor, width: borderWidth))),
        backgroundColor: MaterialStatePropertyAll(
          buttonColor,
        ),
        elevation: const MaterialStatePropertyAll(0),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17, color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
