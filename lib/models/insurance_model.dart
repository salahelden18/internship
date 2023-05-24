import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InsuranceModel extends Equatable {
  final String? title;
  final String? description;
  String? insuranceFile;
  // final

  InsuranceModel({
    required this.description,
    required this.insuranceFile,
    required this.title,
  });

  factory InsuranceModel.fromJson(Map<String, dynamic> json) {
    return InsuranceModel(
      description: json['description'],
      insuranceFile: json['insuranceFile'],
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [title, description, insuranceFile];
}
