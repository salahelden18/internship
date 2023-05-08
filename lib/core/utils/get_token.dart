import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_model.dart';

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final extractedUserDataJson = prefs.getString('userData') as String;

  final extractedUserDataMap =
      json.decode(extractedUserDataJson) as Map<String, dynamic>;

  final extractedUserData = LoginModel.fromJson(extractedUserDataMap);

  return extractedUserData.token;
}
