class CommentModel {
  CommentModel({
    required this.id,
    required this.postId,
    required this.comment,
    required this.createdOn,
  });

  final int id;
  final int postId;
  final String comment;
  final String createdOn;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      postId: json['postId'] ?? 0,
      comment: json['comment'] ?? '',
      createdOn: json['createdOn'] ?? '',
    );
  }
}