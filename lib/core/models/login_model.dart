class LoginModel {
  final String token;
  final String expiration;

  LoginModel({
    required this.token,
    required this.expiration,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] ?? '',
      expiration: json['expiration'] ?? '',
    );
  }
}
