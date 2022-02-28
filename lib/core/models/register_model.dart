class RegisterModel {
  final bool isSuccess;
  final String message;

  RegisterModel({
    required this.isSuccess,
    required this.message,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
