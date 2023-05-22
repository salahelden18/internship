import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/models/letter_model.dart';

import '../core/utils/get_token.dart';

class OfficialLetterService {
  Future<void> applyForOfficialLetter(int id, String companyName) async {
    String? token = await getToken();

    final response = await http.post(Uri.parse(ApiConstants.officialLetter),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'company_name': companyName,
          'internship': id,
        }));

    final decodedReponse = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw HttpException('Something Went Wrong');
    }
  }

  Future<List<LetterModel>> getAllLetters() async {
    final String? token = await getToken();
    final response =
        await http.get(Uri.parse(ApiConstants.getAllLetters), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    });

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw HttpException('Something Went Wrong');
    } else {
      final List<dynamic> list = decodedResponse;
      List<LetterModel> requets =
          list.map((item) => LetterModel.fromJson(item)).toList();
      return requets;
    }
  }
}
