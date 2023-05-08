import 'package:equatable/equatable.dart';

class DownloadableFiles extends Equatable {
  final int id;
  final String title;
  final String file;
  final int department;
  final int year;

  const DownloadableFiles({
    required this.id,
    required this.title,
    required this.file,
    required this.department,
    required this.year,
  });

  factory DownloadableFiles.fromJson(Map<String, dynamic> json) {
    return DownloadableFiles(
      department: json['department'],
      file: json['file'],
      id: json['id'],
      title: json['title'],
      year: json['year'],
    );
  }

  @override
  List<Object?> get props => [id, title, file, department, year];
}
