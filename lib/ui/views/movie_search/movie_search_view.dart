import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/movie.dart';
import 'movie_search_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/movie_search_widgets.dart';

class MovieSearchScreen extends StatelessWidget {
  final List<Movie> movies;

  const MovieSearchScreen({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MovieSearchViewModel>.reactive(
      viewModelBuilder: () => MovieSearchViewModel(movies),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: SearchAppBarWidget(
            searchController: model.searchController,
            onClearSearch: model.clearSearch,
            onSearchChanged: model.searchMovies,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchResultsHeaderWidget(
                hasSearchQuery: model.hasSearchQuery,
                resultsCount: model.searchResults.length,
              ),
              Expanded(
                child: SearchResultsListWidget(
                  searchResults: model.searchResults,
                  onMovieTap: model.navigateToMovieDetail,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 