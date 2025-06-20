import 'package:json_annotation/json_annotation.dart';
import '../core/constants/api_constants.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final int id;
  final String title;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final String overview;
  
  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    required this.releaseDate,
    required this.overview,
  });

  String get fullPosterPath => 
    posterPath != null ? '${ApiConstants.imageBaseUrl}$posterPath' : '';

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, posterPath: $posterPath, releaseDate: $releaseDate}';
  }
} 