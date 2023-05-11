import 'package:equatable/equatable.dart';

class InsuranceModel extends Equatable {
  final String title;
  final String description;
  final String? insuranceFile;
  // final

  const InsuranceModel({
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
