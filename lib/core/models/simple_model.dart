class SimpleModel {
  final int postId;
  final int actionType;

  SimpleModel({
    required this.postId,
    required this.actionType,
  });

  factory SimpleModel.fromJson(Map<String, dynamic> json) {
    return SimpleModel(
      postId: json['postId'] ?? 0,
      actionType: json['actionType'] ?? 0,
    );
  }
}