import 'package:equatable/equatable.dart';

class ParticipantModel extends Equatable {
  final int id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? profilePic;

  const ParticipantModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePic: json['profile_pic'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        firstName,
        lastName,
        profilePic,
      ];
}
