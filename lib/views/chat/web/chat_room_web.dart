import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as ioo;
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_cubit.dart';
import 'package:tweaxy/cubits/chat_web_cubit/chat_web_states.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_states.dart';
import 'package:tweaxy/services/chat_room_service.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:get/get.dart';

class ChatRoomWeb extends StatefulWidget {
  ChatRoomWeb(
      {super.key,
      required this.id,
      required this.avatar,
      required this.username,
      required this.isFirstMsg,
      required this.name,
      required this.conversationID,
      required this.block,
      this.userFollowersNum,
      this.userFollowingsNum});
  final String id;
  final String conversationID;
  String? avatar = "";
  final String username;
  final String name;
  final bool block;
  int? userFollowersNum;
  int? userFollowingsNum;
  final bool isFirstMsg;
  @override
  State<ChatRoomWeb> createState() => _ChatRoomWebState();
}

class _ChatRoomWebState extends State<ChatRoomWeb> {
  late ioo.Socket socket;
  final currentUser = ChatUser(
    id: TempUser.id,
    name: TempUser.username,
    //  profilePhoto: Data.profileImage,
  );
  bool tany = false;
  Rx<ChatViewState> chatViewState = ChatViewState.loading.obs;
  String consversationID = "";
  String usertoken = "";
  late ChatController _chatController;
  int pageSize = 10;
  List<Message> oldMessages = [];
  int pageOffset = 0;
  String userID = "";
  bool isLastPage = false;
  Future loadMessages() async {
    List<String> s = await loadPrefs();
    usertoken = s[1];
    userID = s[0];
    consversationID =
        await ChatRoomService(Dio()).firstConversation(widget.username);
    if (widget.conversationID != "") {
      oldMessages =
          await ChatRoomService(Dio()).getMessages(widget.conversationID, 0);
      consversationID = widget.conversationID;
    } else {
      oldMessages =
          await ChatRoomService(Dio()).getMessages(consversationID, 0);
    }
    if (oldMessages.isEmpty) {
      chatViewState.value = ChatViewState.noData;
    }
    if (_chatController.initialMessageList.isEmpty) {
      _chatController.initialMessageList = oldMessages.reversed.toList();
      chatViewState.value = ChatViewState.hasMessages;
    } else {
      for (var message in oldMessages) {
        _chatController.addMessage(message);
      }
    }
    pageOffset += oldMessages.length;
  }

  void connectsocket() {
    socket = ioo.io('https://tweaxychat.gleeze.com/', <String, dynamic>{
      'transports': ['websocket'], // optional your need for
      'autoConnect': false,
    });
    socket.auth = {"token": TempUser.token};
    socket.connect();

    socket.onConnect((_) {
      log('connect');
    });
    socket.on('event', (data) => log(data.toString()));
    socket.on('fromServer', (_) => log(_.toString()));
    socket.onConnect((data) {
      log(data.toString());
    });
    socket.onConnecting((data) {
      log(data.toString());
    });
    socket.onConnectError((data) {
      log(data.toString());
    });
    socket.onConnectTimeout((data) {
      log(data.toString());
    });
    socket.onError((data) {
      log(data.toString());
    });
    // socket.onDisconnect((_) => log('disconnect'));

    // socket.onAny((event, data) {
    //   log("$event $data");
    // });
    socket.on('message', (data) {
      log("msg$data");
      if (data['senderId'] == widget.id) {
        addmessage(data['text']);
      }
    });
  }

  @override
  void initState() {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          tany) {
        setState(() {
          isLastPage = true;
        });
      } else {
        setState(() {
          isLastPage = false; // Reset isLastPage to false when scrolling down
        });
      }
    });
    _chatController = ChatController(
      initialMessageList: [],
      scrollController: scrollController,
      chatUsers: [
        ChatUser(
            id: widget.id, name: widget.username, profilePhoto: widget.avatar),
      ],
    );
    chatViewState.value = ChatViewState.loading;
    loadMessages();
    connectsocket();
    pageOffset = oldMessages.length;
    super.initState();
  }

  void addmessage(dynamic data) {
    _chatController.addMessage(
        Message(message: data, createdAt: DateTime.now(), sendBy: widget.id));
  }

  @override
  void dispose() {
    socket.disconnect();
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatWebCubit, ChatWebCubitState>(
        builder: (context, state) {
      if (state is ChatWebCubitNoConversationState) {
        dispose();
        return const CircularProgressIndicator();
      } else {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: BlocBuilder<SidebarCubit, SidebarState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<SidebarCubit>(context).openProfile(
                        widget.id,
                        "Following",
                      );
                    },
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.blueGrey[300],
                      backgroundImage: CachedNetworkImageProvider(
                          basePhotosURL + widget.avatar!),
                    ),
                  );
                },
              ),
            ),
            title: Text(widget.name),
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.25,
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isLastPage && !widget.isFirstMsg)
                BlocBuilder<SidebarCubit, SidebarState>(
                  builder: (context, state) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        BlocProvider.of<SidebarCubit>(context).openProfile(
                          widget.id,
                          "Following",
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blueGrey[300],
                              backgroundImage: CachedNetworkImageProvider(
                                  basePhotosURL + widget.avatar!),
                            ),
                          ),
                          Text(
                            widget.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              "@${widget.username}",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Followers: ${widget.userFollowersNum} . Followings: ${widget.userFollowingsNum} ",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                ),
              Expanded(
                child: Obx(
                  () => ChatView(
                    loadingWidget: const CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                    isLastPage: pageOffset < pageSize ? true : false,
                    loadMoreData: () async {
                      if (!isLastPage) {
                        var newMessages = await ChatRoomService(Dio())
                            .getMessages(consversationID, pageOffset);
                        newMessages = newMessages.reversed.toList();
                        _chatController.loadMoreData(newMessages);
                        pageOffset += newMessages.length;
                        setState(() {
                          tany = newMessages.isEmpty;
                        });
                      }
                    },
                    currentUser: currentUser,
                    chatController: _chatController,
                    onSendTap: _onSendTap,
                    featureActiveConfig: FeatureActiveConfig(
                      enableTextField: !widget.block,
                      enablePagination: true,
                      enableOtherUserProfileAvatar: false,
                      enableSwipeToReply: false,
                      receiptsBuilderVisibility: false,
                      enableSwipeToSeeTime: true,
                    ),
                    chatViewState: chatViewState.value,
                    chatViewStateConfig: ChatViewStateConfiguration(
                      loadingWidgetConfig:
                          const ChatViewStateWidgetConfiguration(
                              loadingIndicatorColor: Colors.blue),
                      noMessageWidgetConfig:
                          const ChatViewStateWidgetConfiguration(
                              widget: Text("no message now")),
                      onReloadButtonTap: () {
                        loadMessages();
                      },
                    ),
                    chatBackgroundConfig: const ChatBackgroundConfiguration(
                      backgroundColor: Colors.white,
                    ),
                    sendMessageConfig: SendMessageConfiguration(
                      textFieldBackgroundColor: const Color(0xFFeff3f4),
                      imagePickerIconsConfig:
                          const ImagePickerIconsConfiguration(
                        cameraIconColor: Colors.black,
                        galleryIconColor: Colors.black,
                      ),
                      defaultSendButtonColor: Colors.blue,
                      closeIconColor: Colors.black,
                      textFieldConfig: TextFieldConfiguration(
                        hintText: "Start a message",
                        onMessageTyping: (status) {
                          debugPrint(status.toString());
                        },
                        compositionThresholdTime: const Duration(seconds: 1),
                        textStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                    chatBubbleConfig: ChatBubbleConfiguration(
                      outgoingChatBubbleConfig: const ChatBubble(
                        linkPreviewConfig: LinkPreviewConfiguration(
                          backgroundColor: Colors.black,
                        ),
                        receiptsWidgetConfig: ReceiptsWidgetConfig(
                            showReceiptsIn: ShowReceiptsIn.all),
                        color: Colors.blue,
                      ),
                      inComingChatBubbleConfig: ChatBubble(
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        senderNameTextStyle: const TextStyle(
                            color: Colors.transparent, fontSize: 0),
                        color: const Color(0xFFeff3f4),
                        onMessageRead: (message) {
                          debugPrint('Message Read');
                        },
                      ),
                    ),
                    reactionPopupConfig: ReactionPopupConfiguration(
                      shadow: BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 20,
                      ),
                    ),
                    messageConfig: const MessageConfiguration(
                      imageMessageConfig: ImageMessageConfiguration(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.block)
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: Text(
                    "You can no longer send messages to this person.",
                    style: TextStyle(
                        color: Colors
                            .red), // defaultSendButtonColor: Colors.grey[600],
                  ),
                )
            ],
          ),
        );
      }
    });
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) async {
    if (message.trim().isEmpty) {
      return;
    }
    Message mess = Message(
      id: userID,
      createdAt: DateTime.now(),
      message: message,
      sendBy: currentUser.id,
      replyMessage: replyMessage,
      messageType: messageType,
    );

    // if (_chatController.initialMessageList.isEmpty) {
    //   chatViewState.value = ChatViewState.loading;
    //   _chatController.initialMessageList = [mess];
    //   chatViewState.value = ChatViewState.hasMessages;
    //   _chatController.addMessage(mess);
    // } else {
    _chatController.addMessage(mess);
    // }
    socket.emit(
      'sendMessage',
      {
        "id": consversationID,
        "conversationID": consversationID,
        "text": message,
        "media": null
      },
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      _chatController.initialMessageList.last.setStatus =
          MessageStatus.delivered;
    });
  }
}
