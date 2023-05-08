import 'package:equatable/equatable.dart';
import 'package:internship/models/announcement_model.dart';
import 'package:internship/models/downloadable_files_model.dart';

import 'job_model.dart';

class DataModel extends Equatable {
  final int user;
  final String? cv;
  final List<DownloadableFiles> downloadableFiles;
  final List<JobModel> jobs;
  final List<AnnouncementModel> announcement;

  const DataModel({
    required this.user,
    required this.cv,
    required this.downloadableFiles,
    required this.jobs,
    required this.announcement,
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

    return DataModel(
      cv: json['cv'],
      user: json['user'],
      downloadableFiles: files,
      jobs: jobs,
      announcement: announcements,
    );
  }

  @override
  List<Object?> get props => [user, cv, downloadableFiles, jobs, announcement];
}
