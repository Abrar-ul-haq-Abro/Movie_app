import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../models/movie.dart';
import 'movie_search_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';


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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: TextField(
              controller: model.searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.shimmerBase,
                filled: true,
                contentPadding: EdgeInsets.zero,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.textGrey),
                  onPressed: model.clearSearch,
                ),
              ),
              onChanged: model.searchMovies,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  model.hasSearchQuery ? AppStrings.resultsFound(model.searchResults.length) : AppStrings.topResults,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: model.searchResults.length,
                  itemBuilder: (context, index) {
                    final movie = model.searchResults[index];
                    return InkWell(
                      onTap: () => model.navigateToMovieDetail(movie.id),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: CachedNetworkImage(
                                imageUrl: movie.fullPosterPath,
                                width: 120,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.textDark),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    AppStrings.placeholderGenre,
                                    style: TextStyle(color: AppColors.textGrey),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.more_horiz, color: AppColors.textLink),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 