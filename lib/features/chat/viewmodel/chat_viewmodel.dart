import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ulid/ulid.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../../../features/image_picker/service/image_service.dart';
import '../../../features/image_picker/viewmodel/image_picker_viewmodel.dart';
import '../model/chat_message.dart';
import '../service/websocket_service.dart';

class ChatViewModel extends BaseViewModel {
  final WebSocketService _webSocketService;
  final List<ChatMessage> _messages = [];
  String? _currentUserId;

  ChatViewModel(this._webSocketService);

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  Stream<WebSocketStatus> get connectionStatus =>
      _webSocketService.statusStream;

  String? get currentUserId => _currentUserId;

  Future<void> initialize(String userId, String wsUrl) async {
    _currentUserId = userId;
    // await _webSocketService.connect(wsUrl);

    // Add some example messages
    _addMessage(
      ChatMessage(
        id: '1',
        senderId: 'system',
        content: 'Welcome to the chat! How can I help you today?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        type: MessageType.system,
        avatarUrl: 'https://avatars.githubusercontent.com/u/0',
      ),
    );

    _addMessage(
      ChatMessage(
        id: '2',
        senderId: userId,
        content: 'Hi! I have a question about my insurance policy.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
        avatarUrl: 'https://avatars.githubusercontent.com/u/1',
      ),
    );

    _addMessage(
      ChatMessage(
        id: '3',
        senderId: 'agent',
        content:
            'Of course! I\'d be happy to help. What would you like to know?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
        avatarUrl: 'https://avatars.githubusercontent.com/u/2',
      ),
    );

    // Additional dummy messages
    _addMessage(
      ChatMessage(
        id: '4',
        senderId: userId,
        content: 'I want to check my coverage for water damage.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        avatarUrl: 'https://avatars.githubusercontent.com/u/1',
      ),
    );

    _addMessage(
      ChatMessage(
        id: '5',
        senderId: 'agent',
        content: 'Let me check your policy details...',
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
        avatarUrl: 'https://avatars.githubusercontent.com/u/3',
      ),
    );

    _addMessage(
      ChatMessage(
        id: '6',
        senderId: 'agent',
        content:
            'Your policy covers sudden and accidental water damage up to \$50,000.',
        timestamp: DateTime.now().subtract(const Duration(seconds: 30)),
        avatarUrl: 'https://avatars.githubusercontent.com/u/4',
      ),
    );

    _addMessage(
      ChatMessage(
        id: '7',
        senderId: userId,
        content: 'That\'s great! What about gradual leaks?',
        timestamp: DateTime.now(),
        avatarUrl: 'https://avatars.githubusercontent.com/u/1',
      ),
    );

    // Add messages with different types
    _addMessage(
      ChatMessage(
        id: '8',
        senderId: 'agent',
        content: '/Users/yamingdeng/Downloads/policy-document.pdf',
        timestamp: DateTime.now().subtract(
          const Duration(minutes: 2, seconds: 30),
        ),
        type: MessageType.file,
        avatarUrl: 'https://avatars.githubusercontent.com/u/1',
      ),
    );

    _addMessage(
      ChatMessage(
        id: '9',
        senderId: userId,
        content:
            'https://karryon.com.au/wp-content/uploads/2014/12/shutterstock_120633745.jpg',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        type: MessageType.image,
        avatarUrl: 'https://avatars.githubusercontent.com/u/1',
      ),
    );

    _addMessage(
      ChatMessage(
        id: '10',
        senderId: 'agent',
        content:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
        type: MessageType.video,
        avatarUrl: 'https://avatars.githubusercontent.com/u/1',
      ),
    );

    _addMessage(
      ChatMessage(
        id: '11',
        senderId: 'system',
        content: 'Your claim has been submitted successfully!',
        timestamp: DateTime.now().subtract(const Duration(seconds: 45)),
        type: MessageType.system,
        avatarUrl: 'https://avatars.githubusercontent.com/u/0',
      ),
    );

    _webSocketService.messageStream.listen((data) {
      final message = ChatMessage.fromJson(data);
      _addMessage(message);
      notifyListeners();
    });
  }

  final ImagePickerViewModel _imagePickerViewModel = ImagePickerViewModel(
    ImageService(),
  );

  Future<void> sendMessage(
    String content, {
    MessageType type = MessageType.text,
  }) async {
    if (content.isEmpty || _currentUserId == null) return;

    final message = ChatMessage(
      id: Ulid().toString(),
      senderId: _currentUserId!,
      content: content,
      timestamp: DateTime.now(),
      type: type,
      status: MessageStatus.sending,
    );

    _addMessage(message);
    notifyListeners();

    try {
      _webSocketService.sendMessage(message.toJson());
      _updateMessageStatus(message.id, MessageStatus.sent);
    } catch (e) {
      _updateMessageStatus(message.id, MessageStatus.error);
      debugPrint('Error sending message: $e');
    }
  }

  Future<void> handleAttachment(MessageType type) async {
    try {
      String? content;
      switch (type) {
        case MessageType.image:
          await _imagePickerViewModel.pickImage(ImageSource.gallery);
          content = _imagePickerViewModel.imageFile?.path;
          break;
        case MessageType.video:
          final result = await ImagePicker().pickVideo(
            source: ImageSource.gallery,
          );
          if (result != null) {
            content = result.path;
          }
          break;
        case MessageType.file:
          final result = await FilePicker.platform.pickFiles();
          if (result != null) {
            content = result.files.single.path;
          }
          break;
        default:
          return;
      }

      if (content != null) {
        await sendMessage(content, type: type);
      }
    } catch (e) {
      debugPrint('Error handling attachment: $e');
      setError('Failed to handle attachment');
    }
  }

  void _addMessage(ChatMessage message) {
    _messages.add(message);
    _messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void _updateMessageStatus(String messageId, MessageStatus status) {
    final index = _messages.indexWhere((m) => m.id == messageId);
    if (index != -1) {
      final message = _messages[index];
      _messages[index] = ChatMessage(
        id: message.id,
        senderId: message.senderId,
        content: message.content,
        timestamp: message.timestamp,
        type: message.type,
        status: status,
      );
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }
}
