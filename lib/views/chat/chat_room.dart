import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:socket_io_client/socket_io_client.dart' as ioo;
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/chat_room_service.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:get/get.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom(
      {required this.id,
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
  final bool isFirstMsg;
  final bool block;
  int? userFollowersNum;
  int? userFollowingsNum;
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
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
    if (oldMessages.length < 5) {
      setState(() {
        isLastPage = true;
      });
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: MediaQuery.of(context).size.width * 0.08,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blueGrey[300],
              backgroundImage:
                  CachedNetworkImageProvider(basePhotosURL + widget.avatar!),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.name,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.25,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isLastPage && !widget.isFirstMsg)
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      id: widget.id,
                      text: "",
                    ),
                  ),
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
                  lastSeenAgoBuilderVisibility: true,
                  receiptsBuilderVisibility: true,
                ),
                chatViewState: chatViewState.value,
                chatViewStateConfig: ChatViewStateConfiguration(
                  loadingWidgetConfig: const ChatViewStateWidgetConfiguration(
                      loadingIndicatorColor: Colors.black),
                  noMessageWidgetConfig: const ChatViewStateWidgetConfiguration(
                      widget: Text("no message now")),
                  onReloadButtonTap: () {
                    loadMessages();
                  },
                ),
                chatBackgroundConfig: const ChatBackgroundConfiguration(
                  backgroundColor: Colors.white,
                ),
                sendMessageConfig: SendMessageConfiguration(
                  textFieldBackgroundColor: Colors.grey[300],
                  imagePickerIconsConfig: ImagePickerIconsConfiguration(
                    cameraIconColor: Colors.grey[600],
                    galleryIconColor: Colors.grey[600],
                  ),
                  replyMessageColor: Colors.black,
                  defaultSendButtonColor: Colors.grey[600],
                  replyDialogColor: Colors.grey[300],
                  closeIconColor: Colors.black,
                  textFieldConfig: TextFieldConfiguration(
                    hintText: "Start a message",
                    onMessageTyping: (status) {
                      debugPrint(status.toString());
                    },
                    compositionThresholdTime: const Duration(seconds: 1),
                    textStyle: const TextStyle(color: Colors.black),
                  ),
                  voiceRecordingConfiguration: VoiceRecordingConfiguration(
                    backgroundColor: Colors.black,
                    recorderIconColor: Colors.grey[600],
                    waveStyle: const WaveStyle(
                      showMiddleLine: false,
                      waveColor: Colors.white,
                      extendWaveform: true,
                    ),
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
                    senderNameTextStyle:
                        const TextStyle(color: Colors.transparent, fontSize: 0),
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
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  ),
                ),
                repliedMessageConfig: RepliedMessageConfiguration(
                  repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
                    enableHighlightRepliedMsg: true,
                    highlightColor: Colors.pinkAccent.shade100,
                    highlightScale: 1.1,
                  ),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
            ),
          ),
          if (widget.block)
            const Padding(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              child: Text(
                "You can no longer send messages to this person.",
                style: TextStyle(
                    color: Colors
                        .red), // defaultSendButtonColor: Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) async {
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
