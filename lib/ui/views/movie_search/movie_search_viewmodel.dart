import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/movie.dart';

class MovieSearchViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final List<Movie> _allMovies;
  final TextEditingController searchController = TextEditingController();

  MovieSearchViewModel(this._allMovies);

  List<Movie> _searchResults = [];
  List<Movie> get searchResults => _searchResults;

  bool get hasSearchQuery => searchController.text.isNotEmpty;

  void searchMovies(String query) {
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _allMovies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
  
  void clearSearch() {
    searchController.clear();
    searchMovies('');
  }

  void navigateToMovieDetail(int movieId) {
    _navigationService.navigateToMovieDetailScreen(movieId: movieId);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
} 