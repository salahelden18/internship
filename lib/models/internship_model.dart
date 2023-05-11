import 'package:equatable/equatable.dart';
import 'package:internship/models/coordinator_model.dart';
import 'package:internship/models/practice_submission.dart';

class InternshipModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final CoordinatorModel coordinator;
  final List<PracticeSubmissions> practiceSubmissions;

  const InternshipModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coordinator,
    required this.practiceSubmissions,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> practiceSubmissionsList = json['PractiseSubmissions'];
    final practiceSubmissions = practiceSubmissionsList
        .map((e) => PracticeSubmissions.fromJson(e))
        .toList();

    return InternshipModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coordinator: CoordinatorModel.fromJson(json['coordinator']),
      practiceSubmissions: practiceSubmissions,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, coordinator, practiceSubmissions];
}
