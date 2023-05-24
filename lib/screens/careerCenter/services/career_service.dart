import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/core/utils/get_token.dart';
import 'package:internship/models/insurance_model.dart';
import 'package:internship/screens/careerCenter/model/career_center_model.dart';

class CareerService {
  Future<CareerCenterModel> getAllRequests() async {
    String? token = await getToken();

    final response =
        await http.get(Uri.parse(ApiConstants.careerGetAllRequests), headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    });

    final decodedresponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final CareerCenterModel careerCenterModel =
          CareerCenterModel.fromjson(decodedresponse);
      print(careerCenterModel);
      return careerCenterModel;
    } else {
      throw HttpException('Something Went Wrong in the server');
    }
  }

  Future<InsuranceModel> updateTheSgk(String sgk, int id) async {
    String? token = await getToken();

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Token $token"
    };

    File file = File(sgk);

    final url = Uri.parse(ApiConstants.updateSgkFile);
    final request = http.MultipartRequest('POST', url);

    final multiPartFile = http.MultipartFile(
      'insuranceFile',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
    );

    request.headers.addAll(headers);

    request.files.add(multiPartFile);

    request.fields['PractiseSubmission'] = id.toString();

    var response = await request.send();
    final responseBody =
        await response.stream.bytesToString(); // get response body

    print(response.statusCode);

    if (response.statusCode == 201) {
      final decodedResponse = jsonDecode(responseBody);
      final insurance = InsuranceModel.fromJson(decodedResponse);
      return insurance;
    } else {
      print(responseBody);
      throw HttpException('Unable to upload file');
    }
  }
}
