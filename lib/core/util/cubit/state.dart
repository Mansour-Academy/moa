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
  final String companyName;

  UserLoginSuccess({
    required this.token,
    required this.companyName,
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

class ChangeLoaded extends AppState {}

class PrintRequestPDF extends AppState {}

class BottomChanged extends AppState {}

class AllPostsLoading extends AppState {}

class AllPostsSuccess extends AppState {}

class AllPostsError extends AppState {
  final String message;

  AllPostsError({
    required this.message,
  });
}

class AllSearchPostsLoading extends AppState {}

class AllSearchPostsSuccess extends AppState {}

class AllSearchPostsError extends AppState {
  final String message;

  AllSearchPostsError({
    required this.message,
  });
}

class MessageReceived extends AppState {}

class Search extends AppState {}

class Comment extends AppState {}

class FillCommentMapState extends AppState {}

class ChangeCurrentComment extends AppState {}

class ChangeCurrentCommentDirection extends AppState {}

class ChangeLanguageState extends AppState {}

class LikeActionLoading extends AppState {
  final int postId;

  LikeActionLoading({
    required this.postId,
  });
}

class LikeActionSuccess extends AppState {}

class LikeActionError extends AppState {
  final String message;

  LikeActionError({
    required this.message,
  });
}

class DisLikeActionLoading extends AppState {
  final int postId;

  DisLikeActionLoading({
    required this.postId,
  });
}

class DisLikeActionSuccess extends AppState {}

class DisLikeActionError extends AppState {
  final String message;

  DisLikeActionError({
    required this.message,
  });
}

class CommentActionLoading extends AppState {
  final int postId;

  CommentActionLoading({
    required this.postId,
  });
}

class CommentActionSuccess extends AppState {}

class CommentActionError extends AppState {
  final String message;

  CommentActionError({
    required this.message,
  });
}

class CompanyDomainLoading extends AppState {}

class CompanyDomainSuccess extends AppState {}

class CompanyDomainError extends AppState {
  final String message;

  CompanyDomainError({
    required this.message,
  });
}

class ShareLoading extends AppState {
  final int postId;

  ShareLoading({
    required this.postId,
  });
}

class ShareSuccess extends AppState {}

class ShareError extends AppState {
  final String message;

  ShareError({
    required this.message,
  });
}
