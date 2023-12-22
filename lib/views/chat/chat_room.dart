import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/chat_room_service.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:get/get.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom(
      {super.key,
      required this.id,
      required this.avatar,
      required this.username,
      required this.isFirstMsg,
      required this.name,
      required this.conversationID});
  final String id;
  final String conversationID;
  String? avatar = "";
  final String username;
  final String name;
  final bool isFirstMsg;
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final currentUser = ChatUser(
    id: TempUser.id,
    name: TempUser.username,
    //  profilePhoto: Data.profileImage,
  );
  Rx<ChatViewState> chatViewState = ChatViewState.loading.obs;
  String consversationID = "";
  String usertoken = "";
  late ChatController _chatController;
  List<Message> oldMessages = [];
  int pageOffset = 20;
  String userID = "";
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
      _chatController.initialMessageList = oldMessages;
      chatViewState.value = ChatViewState.hasMessages;
    } else {
      for (var message in oldMessages) {
        _chatController.addMessage(message);
      }
    }
  }

  late Socket socket;
  void connectsocket() async {
    List<String> s = await loadPrefs();
    usertoken = s[1];
    userID = s[0];

    socket = io(
      'https://tweaxychat.gleeze.com/',
      OptionBuilder()
          .setPath("https://tweaxychat.gleeze.com/")
          .setTransports(['pollin'])
          .enableReconnection()
          .enableForceNew()
          .enableForceNewConnection()
          .enableAutoConnect()
          .setExtraHeaders({"Authorization": "Bearer $usertoken"})
          .build(),
    );
    socket.connect();
    // socket = IO.io('https://tweaxychat.gleeze.com/', <String, dynamic>{
    //   'transports': ['polling'],
    // });
    // // socket = IO.io('https://tweaxychat.gleeze.com/');
    // socket.auth = {usertoken};
    //     socket.connect();

    // socket.on('connect_error', (error) {
    //   print('Error connecting to the socket: $error');
    // });

    // socket.on('connect_timeout', (_) {
    //   print('Connection timeout');
    // });

    // socket.on('error', (error) {
    //   print('Socket error: $error');
    // });
  }

  // late IO.Socket socket;
  @override
  void initState() {
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
    _chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      chatUsers: [
        ChatUser(
            id: widget.id, name: widget.username, profilePhoto: widget.avatar),
      ],
    );
    const int pageSize = 20;
    return Scaffold(
      body: Obx(
        () => ChatView(
          loadingWidget: const CircularProgressIndicator(
            color: Colors.blue,
          ),
          isLastPage: pageOffset < pageSize ? true : false,
          loadMoreData: () async {
            var newMessages = await ChatRoomService(Dio())
                .getMessages(widget.conversationID, pageOffset);
            _chatController.loadMoreData(newMessages);
          },
          currentUser: currentUser,
          chatController: _chatController,
          onSendTap: _onSendTap,
          featureActiveConfig: const FeatureActiveConfig(
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
          appBar: ChatViewAppBar(
            leading: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_sharp)),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  // padding: EdgeInsets.symmetric(
                  //     vertical: MediaQuery.of(context).size.height * 0.001),
                  child: CircleAvatar(
                    radius: kIsWeb ? 20 : 20,
                    backgroundColor: Colors.blueGrey[300],
                    backgroundImage: CachedNetworkImageProvider(
                        basePhotosURL + widget.avatar!),
                  ),
                ),
              ],
            ),
            onBackPress: () {
              Navigator.pop(context);
            },
            chatTitle: widget.name,
            chatTitleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.25,
            ),
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
              receiptsWidgetConfig:
                  ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
              color: Colors.blue,
            ),
            inComingChatBubbleConfig: ChatBubble(
              linkPreviewConfig: const LinkPreviewConfiguration(
                linkStyle: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
                backgroundColor: Color.fromARGB(255, 117, 113, 113),
              ),
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
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
    );
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) async {
    // if (consversationID=="") {
    //   ChatRoomService service = ChatRoomService(Dio());
    //   String id = await service.firstConversation(widget.username);
    // }

    Message mess = Message(
      id: userID,
      createdAt: DateTime.now(),
      message: message,
      sendBy: currentUser.id,
      replyMessage: replyMessage,
      messageType: messageType,
    );

    if (_chatController.initialMessageList.isEmpty) {
      chatViewState.value = ChatViewState.loading;
      _chatController.initialMessageList = [mess];
      chatViewState.value = ChatViewState.hasMessages;
    } else {
      _chatController.addMessage(mess);
    }
    var res = socket.emit('sendMessage', {consversationID, message});

    Future.delayed(const Duration(milliseconds: 300), () {
      _chatController.initialMessageList.last.setStatus =
          MessageStatus.delivered;
    });
  }
}
