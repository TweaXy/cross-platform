import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:tweaxy/services/temp_user.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom(
      {super.key,
      required this.id,
      required this.avatar,
      required this.username});
  final String id;
  String? avatar = "";
  final String username;
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final currentUser = ChatUser(
    id: TempUser.id,
    name: TempUser.username,
    //  profilePhoto: Data.profileImage,
  );
  late ChatController _chatController;
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
    return Scaffold(
      body: ChatView(
        currentUser: currentUser,
        chatController: _chatController,
        onSendTap: _onSendTap,
        featureActiveConfig: const FeatureActiveConfig(
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
          onBackPress: () {
            Navigator.pop(context);
          },
          chatTitle: "yara",
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
  ) {
    final id = 1;
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
    Future.delayed(const Duration(milliseconds: 300), () {
      _chatController.initialMessageList.last.setStatus =
          MessageStatus.delivered;
    });
  }
}
