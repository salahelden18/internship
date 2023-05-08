class ErrorModel {
  final List<dynamic> messages;

  ErrorModel({required this.messages});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(messages: json['non_field_errors']);
  }
}
