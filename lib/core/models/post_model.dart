class PostModel {
  final List<String> image;
  final String link;
  final String text;
  final String time;
  final String id;
  final String video;

  PostModel({
    required this.image,
    required this.link,
    required this.text,
    required this.time,
    required this.id,
    required this.video,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      image: json['image'] != null ? List.from((json['image'] as List))
          .map((e) => e.toString())
          .toList() : [],
      link: json['link'] ?? '',
      text: json['text'] ?? '',
      time: json['time'] ?? '',
      video: json['video'] ?? '',
      id: json['id'] ?? '',
    );
  }
}
