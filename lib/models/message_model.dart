import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final int id;
  final int chatId;
  final String sender;
  final String receiver;
  final String content;
  final String date;
  final bool isRead;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.date,
    required this.isRead,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      chatId: json['chat'],
      sender: json['sender'],
      receiver: json['receiver'],
      content: json['content'],
      date: json['timestamp'],
      isRead: json['isread'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        chatId,
        sender,
        receiver,
        content,
        date,
        isRead,
      ];
}
