import 'package:equatable/equatable.dart';

class AnnouncementModel extends Equatable {
  final int id;
  final String title;
  final String content;
  final String datePublished;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.datePublished,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      datePublished: json['date_published'],
    );
  }

  @override
  List<Object?> get props => [id, title, content, datePublished];
}
