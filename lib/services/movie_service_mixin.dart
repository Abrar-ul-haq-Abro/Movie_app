import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../models/movie.dart';
import '../models/movie_detail.dart';
import '../models/video.dart';
import '../core/constants/api_constants.dart';

mixin MovieServiceMixin {
  final Dio _dio = Dio();

  Future<List<Movie>> getUpcomingMovies() async {
    try {
      debugPrint('Making API call to: ${ApiConstants.baseUrl}${ApiConstants.upcomingMovies}');
      
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.upcomingMovies}',
        queryParameters: ApiConstants.defaultQueryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint("MovieList API Response Status Code: ${response.statusCode}");
      debugPrint("MovieList API Response Type: ${response.data.runtimeType}");
      debugPrint("MovieList API Response: ${response.data.toString()}");

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
          final List<dynamic> results = List<dynamic>.from(data['results'] ?? []);
          
          debugPrint("Number of movies found: ${results.length}");
          
          final movies = results.map((movieData) {
            try {
              return Movie.fromJson(Map<String, dynamic>.from(movieData));
            } catch (e) {
              debugPrint("Error parsing movie: $e");
              debugPrint("Problematic movie data: $movieData");
              rethrow;
            }
          }).toList();

          return movies;
        } catch (e) {
          debugPrint("Error parsing response data: $e");
          rethrow;
        }
      } else {
        throw Exception('Failed to load upcoming movies. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching upcoming movies: $e");
      debugPrint("Stack trace: $stackTrace");
      throw Exception('Error fetching upcoming movies: $e');
    }
  }

  Future<MovieDetail> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.movieDetails(movieId)}',
        queryParameters: ApiConstants.defaultQueryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return MovieDetail.fromJson(Map<String, dynamic>.from(response.data));
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error fetching movie details: $e');
    }
  }

  Future<List<Video>> getMovieVideos(int movieId) async {
    try {
      debugPrint('Fetching videos for movie ID: $movieId');
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.movieVideos(movieId)}',
        queryParameters: ApiConstants.defaultQueryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('Videos API Response Status: ${response.statusCode}');
      debugPrint('Videos API Response: ${response.data}');

      if (response.statusCode == 200) {
        final videoResponse = VideoResponse.fromJson(Map<String, dynamic>.from(response.data));
        debugPrint('Total videos found: ${videoResponse.results.length}');
        
        for (var video in videoResponse.results) {
          debugPrint('Video: ${video.name} - Site: ${video.site} - Type: ${video.type} - Key: ${video.key}');
        }
        
        final youtubeTrailers = videoResponse.results.where((video) => video.isYoutubeTrailer).toList();
        debugPrint('YouTube trailers found: ${youtubeTrailers.length}');
        
        return youtubeTrailers;
      } else {
        throw Exception('Failed to load movie videos');
      }
    } catch (e) {
      debugPrint('Error fetching movie videos: $e');
      throw Exception('Error fetching movie videos: $e');
    }
  }
} 