import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/movie.dart';

/// Search app bar widget
class SearchAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final VoidCallback onClearSearch;
  final ValueChanged<String> onSearchChanged;

  const SearchAppBarWidget({
    Key? key,
    required this.searchController,
    required this.onClearSearch,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.background,
      elevation: 0,
      title: TextField(
        controller: searchController,
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
            onPressed: onClearSearch,
          ),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Search results header widget
class SearchResultsHeaderWidget extends StatelessWidget {
  final bool hasSearchQuery;
  final int resultsCount;

  const SearchResultsHeaderWidget({
    Key? key,
    required this.hasSearchQuery,
    required this.resultsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        hasSearchQuery 
            ? AppStrings.resultsFound(resultsCount) 
            : AppStrings.topResults,
        style: const TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold, 
          color: AppColors.textDark
        ),
      ),
    );
  }
}

/// Search results list widget
class SearchResultsListWidget extends StatelessWidget {
  final List<Movie> searchResults;
  final Function(int) onMovieTap;

  const SearchResultsListWidget({
    Key? key,
    required this.searchResults,
    required this.onMovieTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final movie = searchResults[index];
        return SearchResultItemWidget(
          movie: movie,
          onTap: () => onMovieTap(movie.id),
        );
      },
    );
  }
}

/// Individual search result item widget
class SearchResultItemWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const SearchResultItemWidget({
    Key? key,
    required this.movie,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            // Movie poster
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: movie.fullPosterPath,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 120,
                  height: 80,
                  color: AppColors.shimmerBase,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 120,
                  height: 80,
                  color: AppColors.shimmerBase,
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Movie info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 17, 
                      fontWeight: FontWeight.w600, 
                      color: AppColors.textDark
                    ),
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
  }
}

/// Search empty state widget
class SearchEmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const SearchEmptyStateWidget({
    Key? key,
    this.message = 'No movies found',
    this.icon = Icons.search_off,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: AppColors.textGrey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Search loading widget
class SearchLoadingWidget extends StatelessWidget {
  const SearchLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// Movie poster thumbnail widget
class MoviePosterThumbnailWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  const MoviePosterThumbnailWidget({
    Key? key,
    required this.imageUrl,
    this.width = 120,
    this.height = 80,
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: AppColors.shimmerBase,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: AppColors.shimmerBase,
          child: const Icon(Icons.error),
        ),
      ),
    );
  }
}

/// Movie info widget for search results
class MovieInfoWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final Color? subtitleColor;

  const MovieInfoWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.titleColor = AppColors.textDark,
    this.subtitleColor = AppColors.textGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17, 
            fontWeight: FontWeight.w600, 
            color: titleColor,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(color: subtitleColor),
          ),
        ],
      ],
    );
  }
} 