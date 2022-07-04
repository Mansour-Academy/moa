import 'package:moa/core/models/comment_model.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';

class UserModel {
  final String id;
  final String userName;
  final String userEmail;

  UserModel({
    required this.id,
    required this.userName,
    required this.userEmail,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userEmail: json['userEmail'] ?? '',
    );
  }
}