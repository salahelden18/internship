import 'package:equatable/equatable.dart';
import 'package:internship/models/insurance_model.dart';

class PracticeSubmissions extends Equatable {
  final int id;
  final String added;
  final int status;
  final String uploadForm;
  final String? note;
  final String? companyHistory;
  final String trancriptFile;
  final bool isInternational;
  final int student;
  final int practise;
  final InsuranceModel insurance;

  const PracticeSubmissions({
    required this.id,
    required this.added,
    required this.status,
    required this.uploadForm,
    required this.note,
    required this.companyHistory,
    required this.trancriptFile,
    required this.isInternational,
    required this.student,
    required this.practise,
    required this.insurance,
  });

  factory PracticeSubmissions.fromJson(Map<String, dynamic> json) {
    return PracticeSubmissions(
      id: json['id'],
      added: json['added'],
      status: json['status'],
      uploadForm: json['uploaded_form'],
      note: json['note'],
      companyHistory: json['company_history'],
      trancriptFile: json['transcript_file'],
      isInternational: json['ist_international'],
      student: json['student'],
      practise: json['practise'],
      insurance: InsuranceModel.fromJson(json['insurance']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        added,
        status,
        uploadForm,
        note,
        companyHistory,
        trancriptFile,
        isInternational,
        status,
        practise,
        insurance,
      ];
}
