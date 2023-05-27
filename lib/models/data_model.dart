import 'package:equatable/equatable.dart';
import 'package:internship/models/announcement_model.dart';
import 'package:internship/models/chats_model.dart';
import 'package:internship/models/downloadable_files_model.dart';
import 'package:internship/models/internship_model.dart';

import 'job_model.dart';

// ignore: must_be_immutable
class DataModel extends Equatable {
  final int user;
  String? cv;
  final String email;
  final String name;
  final String profilePic;
  final String? departmentName;
  final int? department;
  final int? year;
  final List<DownloadableFiles> downloadableFiles;
  final List<JobModel> jobs;
  final List<AnnouncementModel> announcement;
  final List<InternshipModel> internships;
  final List<ChatsModel> chats;

  DataModel({
    required this.user,
    required this.cv,
    required this.downloadableFiles,
    required this.jobs,
    required this.announcement,
    required this.department,
    required this.departmentName,
    required this.name,
    required this.profilePic,
    required this.year,
    required this.email,
    required this.internships,
    required this.chats,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    // downloadable files
    List<dynamic> downloadableFilesJson = json['downloable_files'];
    final files = downloadableFilesJson
        .map((e) => DownloadableFiles.fromJson(e))
        .toList();

    // jobs
    List<dynamic> jobList = json['jobs'];
    final jobs = jobList.map((e) => JobModel.fromJson(e)).toList();

    // announcement
    List<dynamic> announcementsList = json['annoucnements'];
    final announcements =
        announcementsList.map((e) => AnnouncementModel.fromJson(e)).toList();

    List<dynamic> internshipList = json['internships'];
    final internships =
        internshipList.map((e) => InternshipModel.fromJson(e)).toList();

    List<dynamic> chatList = json['chats'];
    final chats = chatList.map((e) => ChatsModel.fromJson(e)).toList();

    return DataModel(
      cv: json['cv'],
      user: json['user'],
      department: json['department'],
      departmentName: json['department_name'],
      name: json['name'],
      profilePic: json['profile_pic'],
      year: json['year'],
      email: json['email'],
      downloadableFiles: files,
      jobs: jobs,
      announcement: announcements,
      internships: internships,
      chats: chats,
    );
  }

  @override
  List<Object?> get props => [
        user,
        cv,
        downloadableFiles,
        jobs,
        announcement,
        name,
        profilePic,
        department,
        departmentName,
        year,
        email,
        internships,
      ];
}
