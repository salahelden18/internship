import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/core/utils/get_token.dart';
import 'package:internship/models/data_model.dart';

class DataService {
  Future<DataModel> getData() async {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse(ApiConstants.allData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
    );

    print(response.body);

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final dataModel = DataModel.fromJson(decodedResponse);
      return dataModel;
    } else {
      String message = '';
      decodedResponse.forEach((key, value) {
        message = decodedResponse[key];
      });

      throw HttpException(message);
    }
  }
}
