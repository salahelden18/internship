import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:internship/core/constants/api_constants.dart';
import 'package:internship/core/global/http_exception.dart';
import 'package:internship/core/utils/get_token.dart';
import 'package:internship/models/chats_model.dart';
import 'package:internship/models/data_model.dart';
import 'package:internship/models/practice_submission.dart';

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

  Future<String> updateCv(String cv) async {
    String? token = await getToken();

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Token $token"
    };

    File file = File(cv);

    final url = Uri.parse(ApiConstants.updateCv);
    final request = http.MultipartRequest('PATCH', url);

    final multiPartFile = http.MultipartFile(
      'cv',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
    );

    request.headers.addAll(headers);

    request.files.add(multiPartFile);

    var response = await request.send();
    final responseBody =
        await response.stream.bytesToString(); // get response body

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(responseBody);
      return decodedResponse['cv'];
    } else {
      throw HttpException('Unable to upload file');
    }
  }

// Not Finished Yet
  Future<PracticeSubmissions> internshipSubmit(
      Map<String, dynamic> data) async {
    String? token = await getToken();

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Token $token"
    };

    File internFile = File(data['internFile']);
    File transcriptFile = File(data['transkriptFile']);
    File? companyHistoryFile;

    if (data['isInternational'] == true) {
      companyHistoryFile = File(data['companyHistoryFile']);
    }

    final url = Uri.parse(ApiConstants.internSubmit); // Chnage
    final request = http.MultipartRequest('POST', url);

    final multiPartFile = [
      http.MultipartFile(
        'uploaded_form',
        internFile.readAsBytes().asStream(),
        internFile.lengthSync(),
        filename: internFile.path.split('/').last,
      ),
      http.MultipartFile(
        'transcript_file',
        transcriptFile.readAsBytes().asStream(),
        transcriptFile.lengthSync(),
        filename: transcriptFile.path.split('/').last,
      ),
    ];

    if (data['isInternational'] == true) {
      multiPartFile.add(
        http.MultipartFile(
          'company_history',
          companyHistoryFile!.readAsBytes().asStream(),
          companyHistoryFile.lengthSync(),
          filename: companyHistoryFile.path.split('/').last,
        ),
      );
    }

    request.headers.addAll(headers);

    request.files.addAll(multiPartFile);

    request.fields['ist_international'] = data['isInternational'].toString();

    request.fields['practise'] = data['id'].toString();

    var response = await request.send();
    final responseBody =
        await response.stream.bytesToString(); // get response body

    final decodedResponse = jsonDecode(responseBody);

    if (response.statusCode == 201) {
      PracticeSubmissions practiceSubmission =
          PracticeSubmissions.fromJson(decodedResponse);
      return practiceSubmission;
    } else {
      throw HttpException('Unable to upload file');
    }
  }

  Future<String> updateUserProfilePic(String profilePic) async {
    String? token = await getToken();

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Token $token"
    };

    File file = File(profilePic);

    final url = Uri.parse(ApiConstants.updateUser);
    final request = http.MultipartRequest('PATCH', url);

    final multiPartFile = http.MultipartFile(
      'profile_pic',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
    );

    request.headers.addAll(headers);

    request.files.add(multiPartFile);

    var response = await request.send();
    final responseBody =
        await response.stream.bytesToString(); // get response body

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(responseBody);
      return decodedResponse['profile_pic'];
    } else {
      throw HttpException('Unable to upload file');
    }
  }

  Future<ChatsModel> addMessage(int receiverId, String message) async {
    String? token = await getToken();
    final response = await http.post(Uri.parse(ApiConstants.addMessage),
        body: jsonEncode({
          'reciever_id': receiverId,
          'message_content': message,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        });

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw HttpException('Unable To Send Message');
    } else {
      Map<String, dynamic> chat = decodedResponse;

      final chatModel = ChatsModel.fromJson(chat);
      return chatModel;
      // List<dynamic> chat = decodedResponse['messages'];
      // final message = messages[messages.length - 1];
      // print(message);
      // return MessageModel.fromJson(message);
    }
  }
}
