import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final MessageStatus status;
  final String? avatarUrl;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
    this.avatarUrl,
  });

  types.Message toChatUIMessage() {
    final author = types.User(id: senderId, imageUrl: avatarUrl);

    switch (type) {
      case MessageType.text:
      case MessageType.emoji:
      case MessageType.system:
        return types.TextMessage(
          author: author,
          id: id,
          text: content,
          createdAt: timestamp.millisecondsSinceEpoch,
          status: _convertStatus(),
        );
      case MessageType.image:
        return types.ImageMessage(
          author: author,
          id: id,
          uri: content,
          size: 0,
          createdAt: timestamp.millisecondsSinceEpoch,
          status: _convertStatus(),
          name: content.split('/').last, // Provide appropriate metadat
        );
      case MessageType.video:
        return types.VideoMessage(
          author: author,
          id: id,
          uri: content,
          size: 0,
          createdAt: timestamp.millisecondsSinceEpoch,
          status: _convertStatus(),
          name: content.split('/').last,
        );
      case MessageType.audio:
        return types.AudioMessage(
          author: author,
          id: id,
          uri: content,
          size: 0,
          duration: const Duration(seconds: 0),
          createdAt: timestamp.millisecondsSinceEpoch,
          status: _convertStatus(),
          name: content.split('/').last,
        );
      case MessageType.file:
        return types.FileMessage(
          author: author,
          id: id,
          uri: content,
          name: content.split('/').last,
          size: 0,
          createdAt: timestamp.millisecondsSinceEpoch,
          status: _convertStatus(),
        );
    }
  }

  types.Status _convertStatus() {
    switch (status) {
      case MessageStatus.sending:
        return types.Status.sending;
      case MessageStatus.sent:
        return types.Status.sent;
      case MessageStatus.delivered:
        return types.Status.delivered;
      case MessageStatus.read:
        return types.Status.seen;
      case MessageStatus.error:
        return types.Status.error;
    }
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

enum MessageType { text, image, video, audio, file, system, emoji }

enum MessageStatus { sending, sent, delivered, read, error }
