import 'package:equatable/equatable.dart';

class CoordinatorModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String profilePic;

  const CoordinatorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePic,
  });

  factory CoordinatorModel.fromJson(Map<String, dynamic> json) {
    return CoordinatorModel(
      id: json['user'],
      name: json['name'],
      email: json['email'],
      profilePic: json['profile_pic'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, profilePic];
}
