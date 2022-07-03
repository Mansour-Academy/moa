import 'package:moa/core/models/comment_model.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';

class PostModel {
  final int id;
  final String postComment;
  final String userId;
  final int companyId;
  final String createdOn;
  bool liked;
  bool dislike;
  bool isShared;
  bool canShare;
  List<CommentModel> comments;
  final List<PostMediaModel> postMedias;
  final PostStatisticsModel statistics;

  PostModel({
    required this.id,
    required this.postComment,
    required this.userId,
    required this.companyId,
    required this.createdOn,
    required this.liked,
    required this.isShared,
    required this.comments,
    required this.dislike,
    required this.canShare,
    required this.statistics,
    required this.postMedias,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      comments: json['comments'] != null ? List.from((json['comments'] as List))
          .map((e) => CommentModel.fromJson(e))
          .toList() : [],
      postMedias: json['postMedias'] != null ? List.from((json['postMedias'] as List))
          .map((e) => PostMediaModel.fromJson(e))
          .toList() : [],
      id: json['id'] ?? 0,
      postComment: json['postComment'] ?? '',
      userId: json['userId'] ?? '',
      companyId: json['companyId'] ?? 0,
      createdOn: json['createdOn'] ?? '',
      liked: json['liked'] ?? false,
      isShared: json['isShared'] ?? false,
      dislike: json['dislike'] ?? false,
      canShare: json['canShare'] ?? false,
      statistics: PostStatisticsModel.fromJson(json['statistics']),
    );
  }
}

class PostStatisticsModel {
  final int likes;
  final int dislikes;
  final int shares;
  final int views;

  PostStatisticsModel({
    required this.likes,
    required this.dislikes,
    required this.shares,
    required this.views,
  });

  factory PostStatisticsModel.fromJson(Map<String, dynamic> json) {
    return PostStatisticsModel(
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
      shares: json['shares'] ?? 0,
      views: json['views'] ?? 0,
    );
  }
}

class PostMediaModel {
  final int id;
  final String mediaPath;
  final int mediaTypeId;

  PostMediaModel({
    required this.id,
    required this.mediaPath,
    required this.mediaTypeId,
  });

  factory PostMediaModel.fromJson(Map<String, dynamic> json) {
    return PostMediaModel(
      id: json['id'] ?? 0,
      mediaPath: 'https://agre-mobile.it-blocks.com/Post2Teams${json['mediaPath']}',
      mediaTypeId: json['mediaTypeId'] ?? 0,
    );
  }
}