import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/chat/conversation.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/get_conversations_cubit/get_conversations_cubit.dart';
import 'package:tweaxy/cubits/get_conversations_cubit/get_conversations_states.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/services/get_conversation_service.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/chat/direct_message.dart';

class GetConversationsView extends StatefulWidget {
  const GetConversationsView({super.key});

  @override
  State<GetConversationsView> createState() => _GetConversationsViewState();
}

class _GetConversationsViewState extends State<GetConversationsView> {
  GetConversationsService service = GetConversationsService(Dio());
  PagingController<int, ConversationModel> _pagingController =
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
      newItems.removeWhere((element) => element.lastMessage == null);
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

  Future<void> _refresh() async {
    _pagingController.refresh();
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
      body: BlocBuilder<GetConversationsCubit, GetConversationsCubitStates>(
        builder: (context, state) {
          if (state is GetConversationsCubitLoading) {
            _pagingController.dispose();
            _pagingController = PagingController(firstPageKey: 0);
            _pagingController.addPageRequestListener((pageKey) {
              _fetchPage(pageKey);
            });

            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: CustomScrollView(
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
                    noItemsFoundIndicatorBuilder: (context) => Center(
                      heightFactor: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomHeadText(
                              textValue: 'Welcome to your\ninbox!',
                              textAlign: TextAlign.left,
                              letterSpacing: 1.1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 17),
                              child: CustomParagraphText(
                                textValue:
                                    'Drop a line, send photos and more with private conversations between you and others on TweaXy.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CustomPageRoute(
                                        direction: AxisDirection.left,
                                        child: const DirectMesssage()));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                              ),
                              child: const Text(
                                "Write a message",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    newPageProgressIndicatorBuilder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                    itemBuilder: (context, item, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 8.0, top: index == 0 ? 5.0 : 0),
                        child: Conversation(conversation: item),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
