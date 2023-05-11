import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/core/utils/get_token.dart';

class JobService {
  Future<void> applyForJob(String cv, int jobId) async {
    String? token = await getToken();
    final response = await http.post(
      Uri.parse(ApiConstants.applyJob),
      body: jsonEncode(
        {
          'cv': cv,
          'job': jobId,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token'
      },
    );

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode != 201) {
      List<String> messages = [];
      for (var key in decodedResponse.keys) {
        var value = decodedResponse[key];
        if (value is List) {
          for (var message in value) {
            messages.add(message);
          }
        } else {
          messages.add(value);
        }
      }
      throw HttpException(messages[0]);
    }
  }
}
