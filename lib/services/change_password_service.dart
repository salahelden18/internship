import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/core/utils/get_token.dart';

class ChangePasswordService {
  Future<void> changePassword(String oldPassword, String newPassword) async {
    String? token = await getToken();
    final response = await http.post(Uri.parse(ApiConstants.changePassword),
        body: jsonEncode(
          {
            "new_password": newPassword,
            "current_password": oldPassword,
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode == 204) {
      return;
    }

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 400 && decodedResponse is Map<String, dynamic>) {
      List messages = [];
      decodedResponse.forEach((key, value) {
        if (value is List) {
          for (var message in value) {
            messages.add(message);
          }
        }
      });
      throw HttpException(messages[0]);
    }
  }
}
