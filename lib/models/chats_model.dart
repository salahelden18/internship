import 'package:equatable/equatable.dart';
import 'package:internship/models/message_model.dart';
import 'package:internship/models/particepant_model.dart';

class ChatsModel extends Equatable {
  final int id;
  final ParticipantModel firstParticipant;
  final ParticipantModel secondParticipant;
  final List<MessageModel> messages;

  const ChatsModel({
    required this.id,
    required this.firstParticipant,
    required this.secondParticipant,
    required this.messages,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> messagesJson = json['messages'];
    final messages = messagesJson.map((e) => MessageModel.fromJson(e)).toList();

    return ChatsModel(
      id: json['id'],
      firstParticipant: ParticipantModel.fromJson(json['first_participant']),
      secondParticipant: ParticipantModel.fromJson(json['second_participant']),
      messages: messages,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstParticipant,
        secondParticipant,
        messages,
      ];
}
