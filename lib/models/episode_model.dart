class EpisodeModel {
  final String id;
  final String title;
  final String description;
  final String audioUrl;
  final Duration duration;
  final DateTime publishDate;
  
  EpisodeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.duration,
    required this.publishDate,
  });
  
  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      duration: Duration(seconds: json['duration'] ?? 0),
      publishDate: DateTime.parse(json['publishDate'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'audioUrl': audioUrl,
      'duration': duration.inSeconds,
      'publishDate': publishDate.toIso8601String(),
    };
  }
}
