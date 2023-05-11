import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File> downloadFile(String url) async {
  String fileName = basename(url);
  String dir = (await getTemporaryDirectory()).path;
  File file = File('$dir/$fileName');
  if (await file.exists()) {
    // If the file already exists, return it directly
    return file;
  } else {
    // If the file doesn't exist, download it from the URL
    final httpClient = HttpClient();
    final request = await httpClient.getUrl(Uri.parse(url));
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    await file.writeAsBytes(bytes);

    return file;
  }
}
