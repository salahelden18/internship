import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/models/letter_model.dart';

import '../core/utils/get_token.dart';

class OfficialLetterService {
  // Future<void> applyForOfficialLetter(int id, String companyName) async {
  //   String? token = await getToken();

  //   final response = await http.post(Uri.parse(ApiConstants.officialLetter),
  //       headers: {
  //         'Authorization': 'Token $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         'company_name': companyName,
  //         'internship': id,
  //       }));

  //   final decodedReponse = jsonDecode(response.body);

  //   if (response.statusCode != 201) {
  //     throw HttpException('Something Went Wrong');
  //   }
  // }

  Future<void> applyForOfficialLetter(
      int id, String companyName, String transcript) async {
    String? token = await getToken();

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Token $token"
    };

    File file = File(transcript);

    final url = Uri.parse(ApiConstants.officialLetter);
    final request = http.MultipartRequest('POST', url);

    final multiPartFile = http.MultipartFile(
      'transcript_file',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
    );

    request.headers.addAll(headers);

    request.files.add(multiPartFile);

    request.fields['internship'] = id.toString();
    request.fields['company_name'] = companyName;

    var response = await request.send();
    final responseBody =
        await response.stream.bytesToString(); // get response body

    if (response.statusCode != 201) {
      throw HttpException('Something Went Wrong');
    }
  }

// String? token = await getToken();

//     Map<String, String> headers = {
//       "Content-Type": "multipart/form-data",
//       "Authorization": "Token $token"
//     };

//     File file = File(cv);

//     final url = Uri.parse(ApiConstants.updateCv);
//     final request = http.MultipartRequest('PATCH', url);

//     final multiPartFile = http.MultipartFile(
//       'cv',
//       file.readAsBytes().asStream(),
//       file.lengthSync(),
//       filename: file.path.split('/').last,
//     );

//     request.headers.addAll(headers);

//     request.files.add(multiPartFile);

//     var response = await request.send();
//     final responseBody =
//         await response.stream.bytesToString(); // get response body

//     if (response.statusCode == 200) {
//       final decodedResponse = jsonDecode(responseBody);
//       return decodedResponse['cv'];
//     } else {
//       throw HttpException('Unable to upload file');
//     }

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
