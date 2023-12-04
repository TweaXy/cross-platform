import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/Views/profile/likers_profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/account_information.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/profile_icon_button.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_states.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/get_user_by_id.dart';
import 'package:tweaxy/views/profile/edit_profile_screen.dart';
import 'package:tweaxy/views/profile/profile_likes.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class ProfileComponentWeb extends StatefulWidget {
  const ProfileComponentWeb({
    super.key,
    required this.id,
    required this.text,
  });
  final String id;
  final String text;
  @override
  State<ProfileComponentWeb> createState() => _ProfileComponentWebState();
}

class _ProfileComponentWebState extends State<ProfileComponentWeb>
    with SingleTickerProviderStateMixin {
  bool hoverd = false;
  String text = '';
  String token = '';

  String id = '';
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('id')!;
      token = prefs.getString('token')!;
      if (widget.text != '') {
        text = widget.text;
      } else {
        text = 'Edit Profile';
      }
      if (widget.id != '') id = widget.id;
      setState(() {});
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  List<String> listitems = [
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
    'item17',
    'item18',
    'item19',
    'item20',
  ];
  int _selectedTabIndex = 0;

  Color textColor = Colors.black;
  Color buttonColor = Colors.black;
  double borderWidth = 0;
  Color borderColor = Colors.black;
  String profileName = 'Ahmed Samy';
  int postsNumber = 678530;
  void Function() onPressed = () {};
  int? selectedMenu;
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        // print(state.runtimeType);
        if (state is ProfilePageLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        } else if (state is ProfilePageInitialState ||
            state is ProfilePageCompletedState) {
          return FutureBuilder(
            future: GetUserById.instance.getUserById(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              } else {
                var user = snapshot.data!;
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        BlocProvider.of<SidebarCubit>(context)
                            .emit(SidebarExploreState());
                      },
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
                    controller: controller,
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
                                    fit: BoxFit.fill,
                                    imageUrl: user.cover == null
                                        ? kDefaultBannerPhoto
                                        : basePhotosURL + user.cover!,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: PopupMenuButton<int>(
                                                    icon: const Icon(Icons
                                                        .more_horiz_outlined),
                                                    offset:
                                                        const Offset(-180, 0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    initialValue: selectedMenu,
                                                    // Callback that sets the selected popup menu item.
                                                    onSelected: (item) {
                                                      setState(() {
                                                        selectedMenu = item;
                                                      });
                                                    },
                                                    itemBuilder: (BuildContext
                                                            context) =>
                                                        [
                                                      _popupMenu(
                                                          0,
                                                          Icons.link_outlined,
                                                          'Copy link to profile'),
                                                      _popupMenu(
                                                          1,
                                                          Icons
                                                              .volume_off_outlined,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ProfileIconButton(
                                                      borderWidth: 1,
                                                      icon: Icons.mail_outline,
                                                      onPressed: () {},
                                                      color: Colors.white,
                                                      iconColor: Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                      _followEditButton(user, context),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height / 6.7,
                              left: 15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        '$basePhotosURL${user.avatar}',
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
                          website: user.website ?? '',
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
                            ),
                          ),
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
                      if (_selectedTabIndex == 2) const ProfileLikes(),
                      if (_selectedTabIndex != 2)
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
        } else {
          return Container();
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

  Widget _followEditButton(User user, BuildContext currContext) {
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
          context: currContext,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.white),
            ),
            content: SizedBox(
              width: 500,
              height: 700,
              child: EditProfileScreen(user: user),
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
