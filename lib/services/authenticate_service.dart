import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/models/error_model.dart';
import 'package:internship/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateService {
  Future<LoginModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.loginUrl),
      body: json.encode({
        'username': email,
        'password': password,
      }),
      headers: {
        'content-type': 'application/json',
      },
    );

    final decodedResponse = jsonDecode(response.body);

    if (decodedResponse['non_field_errors'] != null) {
      final errorMessage = ErrorModel.fromJson(decodedResponse);

      throw HttpException(errorMessage.messages[0]);
    } else {
      final prefs = await SharedPreferences.getInstance();

      LoginModel loginModel = LoginModel.fromJson(decodedResponse);

      await prefs.setString('userData', json.encode(loginModel.toJson()));

      return loginModel;
    }
  }

  Future<String> signup(String email) async {
    final response = await http.post(
      Uri.parse(ApiConstants.registerUrl),
      body: json.encode({
        'email': email,
      }),
      headers: {'content-type': 'application/json'},
    );

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 201 && decodedResponse is Map<String, dynamic>) {
      final List<String> messages = [];

      decodedResponse
          .forEach((key, value) => messages.add(decodedResponse[key]));

      return messages[0];
    } else {
      final List<String> messages = [];

      decodedResponse
          .forEach((key, value) => messages.add(decodedResponse[key]));

      throw HttpException(messages[0]);
    }
  }

  Future<LoginModel?>? autoLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    if (!sharedPreferences.containsKey('userData')) {
      return null;
    }

    final extractedUserDataJson =
        sharedPreferences.getString('userData') as String;

    final extractedUserDataMap =
        json.decode(extractedUserDataJson) as Map<String, dynamic>;

    final extractedUserData = LoginModel.fromJson(extractedUserDataMap);

    return extractedUserData;
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post(Uri.parse(ApiConstants.logoutUrl), headers: {
      'Content-Type': 'application/json',
    });

    await prefs.remove('userData');
  }
}
