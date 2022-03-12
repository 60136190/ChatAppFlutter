import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image , video}
enum MessageStatus { not_sent , not_view , viewed}

class ChatMessage{
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage(this.text, @required this.messageType,@required this.messageStatus,@required this.isSender);
}

List demeChatMessage = [
  ChatMessage('Hello thainam', ChatMessageType.text, MessageStatus.viewed, false),
  ChatMessage('Hello', ChatMessageType.text, MessageStatus.viewed, true),
  ChatMessage('Good morning', ChatMessageType.text, MessageStatus.not_view, false),
  ChatMessage('Thanks so much', ChatMessageType.text, MessageStatus.viewed, true),
  ChatMessage('You are welcome', ChatMessageType.text, MessageStatus.viewed, false),
  ChatMessage('Hello', ChatMessageType.text, MessageStatus.viewed, false),
  ChatMessage('Hello thainam', ChatMessageType.text, MessageStatus.viewed, false),
  ChatMessage('Hello', ChatMessageType.text, MessageStatus.viewed, true),
  ChatMessage('Good morning', ChatMessageType.text, MessageStatus.not_view, false),
  ChatMessage('Thanks so much', ChatMessageType.text, MessageStatus.viewed, true),
  ChatMessage('You are welcome', ChatMessageType.text, MessageStatus.viewed, false),
  ChatMessage('Hello', ChatMessageType.text, MessageStatus.viewed, false),
];