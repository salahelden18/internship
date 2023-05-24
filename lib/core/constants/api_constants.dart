class ApiConstants {
  static const String baseUrl = 'https://openclues.pythonanywhere.com';

  static const String loginUrl = '$baseUrl/token/login/';
  static const String changePassword = '$baseUrl/user/users/set_password/';
  static const String allData = '$baseUrl/student/api/data';
  static const String updateCv = '$baseUrl/student/api/cvupdate';
  static const String applyJob = '$baseUrl/student/api/job/applay';
  static const String logoutUrl = '$baseUrl/token/logout/';
  static const String internSubmit = '$baseUrl/student/api/intershipsubmittion';
  static const String updateUser = '$baseUrl/student/api/update';
  static const String registerUrl = '$baseUrl/api/register';
  static const String officialLetter = '$baseUrl/student/api/requestletter';
  static const String getAllLetters = '$baseUrl/student/api/requestletters';
  static const String careerGetAllRequests = '$baseUrl/career/api/';
  static const String updateSgkFile = '$baseUrl/career/api/insurances/';
}
