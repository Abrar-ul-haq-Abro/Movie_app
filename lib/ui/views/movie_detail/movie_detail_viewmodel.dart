import 'package:movie_app/ui/views/movie_detail/video_player_screen.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter/material.dart';

import '../../../app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.router.dart';
import '../../../models/movie_detail.dart';
import '../../../models/video.dart';
import '../../../services/movie_service_mixin.dart';

class MovieDetailViewModel extends BaseViewModel with MovieServiceMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  MovieDetail? _movieDetail;
  List<Video> _videos = [];
  bool _hasError = false;
  String _errorMessage = '';

  MovieDetail? get movieDetail => _movieDetail;
  List<Video> get videos => _videos;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  bool get hasTrailer => _videos.isNotEmpty;

  Future<void> init(int movieId) async {
    setBusy(true);
    try {
      _movieDetail = await getMovieDetails(movieId);
      _videos = await getMovieVideos(movieId);
      debugPrint('Found ${_videos.length} videos');
      if (_videos.isNotEmpty) {
        debugPrint('First video ID: ${_videos.first.youtubeVideoId}');
        debugPrint('First video key: ${_videos.first.key}');
        debugPrint('First video site: ${_videos.first.site}');
        debugPrint('First video type: ${_videos.first.type}');
      }
      _hasError = false;
      _errorMessage = '';
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      debugPrint('Error in init: $e');
    } finally {
      setBusy(false);
    }
  }

  void playTrailer(BuildContext context) {
    try {
      debugPrint('playTrailer called');
      debugPrint('Videos count: ${_videos.length}');
      
      if (_videos.isEmpty) {
        debugPrint('No trailers available');
        return;
      }
      
      final video = _videos.first;
      final videoId = video.youtubeVideoId;
      final movieTitle = _movieDetail?.title ?? 'Movie Trailer';
      
      debugPrint('Navigating to video player with video ID: $videoId');
      
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(
            videoId: videoId,
            movieTitle: movieTitle,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error playing trailer: $e');
    }
  }

  void navigateToBooking() {
    if (_movieDetail != null) {
      _navigationService.navigateToBookingScreen(movie: _movieDetail!);
    }
  }
} 