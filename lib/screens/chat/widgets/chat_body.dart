import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../../../features/chat/model/chat_message.dart';

class ChatBody extends StatelessWidget {
  final List<ChatMessage> messages;
  final String currentUserId;
  final Function(String) onSendMessage;
  final Function() onAttachmentPressed;
  final Function(BuildContext, types.Message) onMessageTap;

  const ChatBody({
    super.key,
    required this.messages,
    required this.currentUserId,
    required this.onSendMessage,
    required this.onAttachmentPressed,
    required this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    final chatMessages = messages.map((m) => m.toChatUIMessage()).toList();

    return Chat(
      messages: chatMessages,
      onSendPressed: (types.PartialText message) {
        onSendMessage(message.text);
      },
      onAttachmentPressed: onAttachmentPressed,
      onMessageTap: onMessageTap,
      user: types.User(
        id: currentUserId,
        imageUrl: 'https://avatars.githubusercontent.com/u/1',
      ),
      showUserAvatars: true,
      showUserNames: true,
      theme: DefaultChatTheme(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        primaryColor: Theme.of(context).primaryColor,
        secondaryColor: Colors.grey[300] ?? Colors.grey,
        messageBorderRadius: 15,
        inputElevation: 2,
        inputBorderRadius: BorderRadius.circular(15),
        inputMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        inputPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        inputTextStyle: const TextStyle(fontSize: 15),
        inputBackgroundColor: Colors.grey[200]!,
        inputTextColor: Colors.black87,
        inputContainerDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[200]!, width: 1.0),
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
