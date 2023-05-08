import 'package:equatable/equatable.dart';

class JobModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String employementType;
  final int salary;
  final CompanyModel company;

  const JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.employementType,
    required this.salary,
    required this.company,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      employementType: json['employment_type'],
      salary: json['salary'],
      company: CompanyModel.fromJson(json['company']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        employementType,
        salary,
        company,
      ];
}

class CompanyModel extends Equatable {
  final int id;
  final String title;
  final String logo;
  final String location;

  const CompanyModel(this.id, this.title, this.logo, this.location);

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      json['id'],
      json['title'],
      json['logo'],
      json['location'],
    );
  }

  @override
  List<Object?> get props => [id, title, logo, location];
}
