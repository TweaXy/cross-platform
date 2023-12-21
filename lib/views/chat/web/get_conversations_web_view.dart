import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tweaxy/components/chat/conversation.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_cubit.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_states.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/models/conversation_model.dart';
import 'package:tweaxy/services/get_conversation_service.dart';
import 'package:tweaxy/views/chat/web/chat_room_web.dart';
import 'package:tweaxy/views/chat/web/diect_message_web.dart';
import 'package:tweaxy/views/chat/web/no_convesations_web_view.dart';

class GetConversationsWebView extends StatefulWidget {
  const GetConversationsWebView({super.key});

  @override
  State<GetConversationsWebView> createState() =>
      _GetConversationsWebViewState();
}

class _GetConversationsWebViewState extends State<GetConversationsWebView> {
  GetConversationsService service = GetConversationsService(Dio());
  int selectedItem = 0;
  int item = 0;
  final PagingController<int, ConversationModel> _pagingController =
      PagingController(firstPageKey: 0);

  final int _pageSize = 7;

  @override
  void initState() {
    super.initState();
    selectedItem = 1;
    item = 1;
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatWebCubit(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 0.5,
                  ),
                  right: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text(
                      "Messages",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20,
                        letterSpacing: 0.4,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const DirectMesssageWeb(),
                          barrierColor: const Color.fromARGB(100, 97, 119, 129),
                          barrierDismissible: false,
                        );
                      },
                      icon: const Icon(
                        AppIcon.newMessage,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  CustomScrollView(
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
                          noItemsFoundIndicatorBuilder: (context) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.03,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.015),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomHeadText(
                                  textValue: 'Welcome to your\ninbox!',
                                  textAlign: TextAlign.left,
                                  size: 32,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 20),
                                  child: CustomParagraphText(
                                    textValue:
                                        'Drop a line, send photos and more with private conversations between you and others on TweaXy.',
                                    textAlign: TextAlign.left,
                                    size: 18,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const DirectMesssageWeb(),
                                      barrierColor: const Color.fromARGB(
                                          100, 97, 119, 129),
                                      barrierDismissible: false,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1e9aeb),
                                    shadowColor: Colors.transparent,
                                    splashFactory: NoSplash.splashFactory,
                                    elevation: 20,
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.015),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
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
                          newPageProgressIndicatorBuilder: (context) =>
                              const Center(
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
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
              ),
              child: BlocBuilder<ChatWebCubit, ChatWebCubitState>(
                builder: (context, state) {
                  if (state is ChatWebCubitNoConversationState) {
                    return const NoConversationsWebView();
                  }
                  if (state is ChatWebCubitConversationState) {
                    return const ChatRoomWeb();
                  } else {
                    return const NoConversationsWebView();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _globalOnTap(index) {
    setState(() {
      selectedItem = index;
    });
  }
}
