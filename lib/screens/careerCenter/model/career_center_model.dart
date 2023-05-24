import 'package:equatable/equatable.dart';
import 'package:internship/models/insurance_model.dart';

class CareerCenterModel extends Equatable {
  final int id;
  final List<PracticeSubmissionCareer> practiceSubmissions;

  const CareerCenterModel(
      {required this.id, required this.practiceSubmissions});

  factory CareerCenterModel.fromjson(Map<String, dynamic> json) {
    List<dynamic> practises = json['practises_submissions'];
    final practiceSubmissions =
        practises.map((e) => PracticeSubmissionCareer.fromJson(e)).toList();

    return CareerCenterModel(
      id: json['user'],
      practiceSubmissions: practiceSubmissions,
    );
  }

  @override
  List<Object?> get props => [id, practiceSubmissions];
}

class PracticeSubmissionCareer extends Equatable {
  final int id;
  final String studentEmail;
  final String studentProfileImage;
  final String coordinatorName;
  final String internshipTitle;
  final int status;
  final int studentId;
  final int internshipId;
  final InsuranceModel insurance;

  const PracticeSubmissionCareer({
    required this.id,
    required this.studentEmail,
    required this.studentProfileImage,
    required this.coordinatorName,
    required this.internshipTitle,
    required this.status,
    required this.studentId,
    required this.internshipId,
    required this.insurance,
  });

  factory PracticeSubmissionCareer.fromJson(Map<String, dynamic> json) {
    return PracticeSubmissionCareer(
      id: json['id'],
      studentEmail: json['student_email'],
      studentProfileImage: json['student_profile'],
      coordinatorName: json['coordinator_name'],
      internshipTitle: json['internship_title'],
      status: json['status'],
      studentId: json['student'],
      internshipId: json['practise'],
      insurance: InsuranceModel.fromJson(
        json['insurance'],
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        studentEmail,
        studentProfileImage,
        coordinatorName,
        internshipTitle,
        status,
        studentId,
        internshipId,
        insurance,
      ];
}
