import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/chat/conversation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/services/get_conversation_service.dart';
import 'package:tweaxy/services/temp_user.dart';

class GetConversationsView extends StatefulWidget {
  GetConversationsView({super.key});

  @override
  State<GetConversationsView> createState() => _GetConversationsViewState();
}

class _GetConversationsViewState extends State<GetConversationsView> {
  GetConversationsService service = GetConversationsService(Dio());
  final PagingController<int, ConversationModel> _pagingController =
      PagingController(firstPageKey: 0);

  final int _pageSize = 7;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<ConversationModel> newItems =
          await service.getConversations(null, limit: 7, pageNumber: pageKey);
      log(newItems.toString());
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage:
                CachedNetworkImageProvider(basePhotosURL + TempUser.image),
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
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Conversation(conversation: item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
