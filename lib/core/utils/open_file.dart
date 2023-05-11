import 'dart:io';

import 'package:open_file_plus/open_file_plus.dart';

Future openFile(File file) async {
  final url = file.path;

  OpenFile.open(url);
}
