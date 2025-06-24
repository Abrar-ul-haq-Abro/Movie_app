import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/movie.dart';
import '../views/movie_list/movie_list_viewmodel.dart';

/// Loading state widget with shimmer effect
class MovieListLoadingWidget extends StatelessWidget {
  const MovieListLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

/// Error state widget
class MovieListErrorWidget extends StatelessWidget {
  final String error;

  const MovieListErrorWidget({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              AppStrings.errorLoadingMovies(error),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.error),
            ),
          ],
        ),
      ),
    );
  }
}

/// Movie list widget
class MovieListWidget extends StatelessWidget {
  final MovieListViewModel model;
  final BuildContext context;

  const MovieListWidget({
    Key? key,
    required this.model,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: model.movies.length,
      itemBuilder: (context, index) {
        final movie = model.movies[index];
        return MovieCardWidget(
          movie: movie,
          onTap: () => model.navigateToMovieDetail(movie.id),
        );
      },
    );
  }
}

/// Individual movie card widget
class MovieCardWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCardWidget({
    Key? key,
    required this.movie,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            // Movie poster image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: movie.fullPosterPath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.shimmerBase,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.shimmerBase,
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.textDark.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Movie title
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                movie.title,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Movie poster image widget
class MoviePosterWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const MoviePosterWidget({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        color: AppColors.shimmerBase,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.shimmerBase,
        child: const Icon(Icons.error),
      ),
    );
  }
}

/// Shimmer loading widget
class ShimmerLoadingWidget extends StatelessWidget {
  final int itemCount;
  final double height;
  final EdgeInsets margin;

  const ShimmerLoadingWidget({
    Key? key,
    this.itemCount = 3,
    this.height = 200,
    this.margin = const EdgeInsets.only(bottom: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerBase,
          highlightColor: AppColors.shimmerHighlight,
          child: Container(
            height: height,
            margin: margin,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

/// Error display widget
class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final Color? textColor;
  final Color? iconColor;

  const ErrorDisplayWidget({
    Key? key,
    required this.message,
    this.icon = Icons.error_outline,
    this.iconSize = 48,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor ?? AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 