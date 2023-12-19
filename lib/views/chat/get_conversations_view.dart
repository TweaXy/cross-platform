import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/chat/conversation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/services/temp_user.dart';

class GetConversationsView extends StatelessWidget {
  GetConversationsView({super.key});
  final PagingController<int, ConversationModel> _pagingController =
      PagingController(firstPageKey: 0);

  final conversationList = [
    ConversationModel(
        photo: TempUser.image,
        username: "Hambola_22",
        name: "Hambola",
        lastmessage: "chesseeeeeeburgeerr",
        time: "1d"),
    ConversationModel(
        photo: TempUser.image,
        username: "Hambola_22",
        name: "Hambola",
        lastmessage: "chesseeeeeeburgeerr",
        time: "1d"),
    ConversationModel(
        photo: TempUser.image,
        username: "Hambola_22",
        name: "Hambola",
        lastmessage: "chesseeeeeeburgeerr",
        time: "1d"),
    ConversationModel(
        photo: TempUser.image,
        username: "Hambola_22",
        name: "Hambola",
        lastmessage: "chesseeeeeeburgeerr",
        time: "1d"),
    ConversationModel(
        photo: TempUser.image,
        username: "Hambola_22",
        name: "Hambola",
        lastmessage: "chesseeeeeeburgeerr",
        time: "1d"),
  ];

  _fetchPage() {
    _pagingController.appendPage(conversationList, 5);
  }

  @override
  Widget build(BuildContext context) {
    _fetchPage();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey[300],
            height: 0.7,
          ),
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
              backgroundImage:
                  CachedNetworkImageProvider(basePhotosURL + TempUser.image),
            ),
          ),
        ),
        titleSpacing: 10,
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          PagedSliverList<int, ConversationModel>(
            shrinkWrapFirstPageIndicators: true,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              animateTransitions: true,
              firstPageProgressIndicatorBuilder: (context) {
                return const Center(
                  heightFactor: 3,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              },
              newPageProgressIndicatorBuilder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              itemBuilder: (context, item, index) {
                return Conversation(conversation: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
