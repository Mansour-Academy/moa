class GovernmentModel {
  final int id;
  final String code;
  final String description;

  GovernmentModel({
    required this.id,
    required this.code,
    required this.description,
  });

  factory GovernmentModel.fromJson(Map<String, dynamic> json) {
    return GovernmentModel(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
