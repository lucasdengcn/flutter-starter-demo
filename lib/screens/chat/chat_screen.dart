import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/chat/model/chat_message.dart';
import '../../features/chat/service/websocket_service.dart';
import '../../features/chat/viewmodel/chat_viewmodel.dart';
import 'widgets/attachment_menu.dart';
import 'widgets/chat_body.dart';
import 'widgets/chat_header.dart';

class ChatScreen extends StatelessWidget {
  final String userId;
  final String wsUrl;

  const ChatScreen({super.key, required this.userId, required this.wsUrl});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => ChatViewModel(WebSocketService())..initialize(userId, wsUrl),
      child: const ChatView(),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: ChatHeader(connectionStatus: viewModel.connectionStatus),
      ),
      body: ChatBody(
        messages: viewModel.messages,
        currentUserId: viewModel.currentUserId ?? '',
        onSendMessage: (text) => viewModel.sendMessage(text),
        onAttachmentPressed: () async {
          final result = await showModalBottomSheet<MessageType>(
            context: context,
            builder:
                (context) => AttachmentMenu(
                  onAttachmentSelected: (type) => Navigator.pop(context, type),
                  onEmojiSelected: (emoji) {
                    viewModel.sendMessage(emoji, type: MessageType.emoji);
                  },
                ),
          );
          if (result != null) {
            await viewModel.handleAttachment(result);
          }
        },
        onMessageTap: (context, message) async {
          // Handle message taps based on type
        },
      ),
    );
  }
}
