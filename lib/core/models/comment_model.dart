class MainCommentModel {
  final List<CommentModel> data;

  MainCommentModel({
    required this.data,
  });

  factory MainCommentModel.fromJson(Map<String, dynamic> json) {
    return MainCommentModel(
      data: List.from((json['data'] as List))
          .map((e) => CommentModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CommentModel {
  CommentModel({
    required this.id,
    required this.comment,
  });

  late final String id;
  late final String comment;

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
  }

  Map toJson() => {
        'id': id,
        'comment': comment,
      };
}