import 'package:equatable/equatable.dart';

class LetterModel extends Equatable {
  final int? id;
  final int? status;
  final String? officialLetter;
  final int? internshipId;
  final int? studentId;
  final String? internshipName;
  final String? companyName;

  const LetterModel({
    required this.id,
    required this.status,
    required this.officialLetter,
    required this.internshipId,
    required this.studentId,
    required this.companyName,
    required this.internshipName,
  });

  factory LetterModel.fromJson(Map<String, dynamic> json) {
    return LetterModel(
        id: json['id'],
        status: json['status'],
        officialLetter: json['official_letter'],
        internshipId: json['internship'],
        studentId: json['stundet'],
        companyName: json['company_name'],
        internshipName: json['internship_name']);
  }

  @override
  List<Object> get props => [
        id ?? '',
        status ?? '',
        officialLetter ?? '',
        internshipId ?? '',
        studentId ?? '',
        companyName ?? '',
        internshipName ?? ''
      ];
}
