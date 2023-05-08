class LoginModel {
  final String token;
  final int id;
  final String type;

  LoginModel({required this.token, required this.id, required this.type});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        token: json['auth_token'], id: json['user_id'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'auth_token': token,
      'user_id': id,
      'type': type,
    };
  }
}
