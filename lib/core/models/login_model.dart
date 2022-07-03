class LoginModel {
  final String token;
  final String expiration;
  final String companyName;

  LoginModel({
    required this.token,
    required this.expiration,
    required this.companyName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] ?? '',
      expiration: json['expiration'] ?? '',
      companyName: json['companyName'] ?? '',
    );
  }
}
