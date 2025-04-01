class ContentRecommendation {
  final String title;
  final String imageUrl;
  final String? subtitle;

  const ContentRecommendation({
    required this.title,
    required this.imageUrl,
    this.subtitle,
  });

  factory ContentRecommendation.fromJson(Map<String, dynamic> json) {
    return ContentRecommendation(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      subtitle: json['subtitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'imageUrl': imageUrl, 'subtitle': subtitle};
  }
}
