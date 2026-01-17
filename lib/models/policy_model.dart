class PolicyModel {
  final String title;
  final String body;

  PolicyModel({
    required this.title,
    required this.body,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}
