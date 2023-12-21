import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/chat_room_service.dart';
import 'package:tweaxy/services/temp_user.dart';

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
  String consversationID = "";

  late ChatController _chatController;
  List<Message> oldMessages = [];
  int pageOffset = 20;
  Future loadMessages() async {
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
    socket = IO.io(
        'https://tweaxybackend.mywire.org/api/v1/conversations/$consversationID');
    // socket.on('message', (data) => addmessage(data));
    socket.connect();
    socket.on('connect_error', (error) {
      print('Error connecting to the socket: $error');
    });

    socket.on('connect_timeout', (_) {
      print('Connection timeout');
    });

    socket.on('error', (error) {
      print('Socket error: $error');
    });
    socket.connect();
  }

  late IO.Socket socket;
  @override
  void initState() {
    super.initState();

    Future(() async {
      await loadMessages();
    });

    pageOffset = oldMessages.length;
  }

  void addmessage(dynamic data) {
    _chatController.addMessage(
        Message(message: data, createdAt: DateTime.now(), sendBy: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    _chatController = ChatController(
      initialMessageList: oldMessages,
      scrollController: ScrollController(),
      chatUsers: [
        ChatUser(
            id: widget.id, name: widget.username, profilePhoto: widget.avatar),
      ],
    );
    const int pageSize = 20;
    return Scaffold(
      body: ChatView(
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
        chatViewState: ChatViewState.hasMessages,
        chatViewStateConfig: ChatViewStateConfiguration(
          noMessageWidgetConfig: const ChatViewStateWidgetConfiguration(
              widget: Text("no message now")),
          onReloadButtonTap: () {},
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
    final int id = 1;
    _chatController.addMessage(
      Message(
        id: id.toString(),
        createdAt: DateTime.now(),
        message: message,
        sendBy: currentUser.id,
        replyMessage: replyMessage,
        messageType: messageType,
      ),
    );
    socket.onConnect((_) {
      print('connect');
      socket.emit('sendMessage', {"text": message, "media": []});
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      _chatController.initialMessageList.last.setStatus =
          MessageStatus.delivered;
    });
  }
}
