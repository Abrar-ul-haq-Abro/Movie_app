import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class VideoResponse {
  final int id;
  final List<Video> results;

  VideoResponse({required this.id, required this.results});

  factory VideoResponse.fromJson(Map<String, dynamic> json) => _$VideoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VideoResponseToJson(this);
}

@JsonSerializable()
class Video {
  final String id;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;
  final bool official;
  @JsonKey(name: 'published_at')
  final String publishedAt;

  Video({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  bool get isYoutubeTrailer => 
    site.toLowerCase() == 'youtube' && type.toLowerCase() == 'trailer';

  String get youtubeUrl => 'https://youtu.be/$key';
  
  // YouTube video ID for the player
  String get youtubeVideoId => key;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
} 