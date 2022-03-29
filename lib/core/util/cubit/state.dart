import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class Empty extends AppState {}

class Loading extends AppState {}

class Loaded extends AppState {}

class ThemeLoaded extends AppState {}

class LanguageLoaded extends AppState {}

class ChangeSelectedGovernment extends AppState {}

class UserLoginLoading extends AppState {}

class UserLoginSuccess extends AppState {
  final String token;

  UserLoginSuccess({
    required this.token,
  });
}

class UserLoginError extends AppState {
  final String message;

  UserLoginError({
    required this.message,
  });
}

class GetAllGovernmentsLoading extends AppState {}

class GetAllGovernmentsSuccess extends AppState {}

class GetAllGovernmentsError extends AppState {
  final String message;

  GetAllGovernmentsError({
    required this.message,
  });
}

class UserRegisterLoading extends AppState {}

class UserRegisterSuccess extends AppState {}

class UserRegisterError extends AppState {
  final String message;

  UserRegisterError({
    required this.message,
  });
}

class AllRequestedLoading extends AppState {}

class AllRequestedSuccess extends AppState {}

class AllRequestedError extends AppState {
  final String message;

  AllRequestedError({
    required this.message,
  });
}

class ChangeLoaded extends AppState {}

class PrintRequestPDF extends AppState {}

class BottomChanged extends AppState {}

class PostsLoaded extends AppState {}

class MessageReceived extends AppState {}

class Search extends AppState {}

class Comment extends AppState {}

class FillCommentMapState extends AppState {}

class ChangeCurrentComment extends AppState {}

class ChangeCurrentCommentDirection extends AppState {}

class ChangeLanguageState extends AppState {}