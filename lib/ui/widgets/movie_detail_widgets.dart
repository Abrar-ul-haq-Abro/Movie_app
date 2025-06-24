import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/movie_detail.dart';

/// Movie detail loading widget
class MovieDetailLoadingWidget extends StatelessWidget {
  const MovieDetailLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}

/// Movie detail error widget
class MovieDetailErrorWidget extends StatelessWidget {
  final String errorMessage;

  const MovieDetailErrorWidget({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

/// Movie backdrop image widget
class MovieBackdropWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final BoxFit fit;

  const MovieBackdropWidget({
    Key? key,
    required this.imageUrl,
    this.height = 500,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: height,
      fit: fit,
    );
  }
}

/// Movie backdrop gradient overlay widget
class MovieBackdropGradientWidget extends StatelessWidget {
  final double height;

  const MovieBackdropGradientWidget({
    Key? key,
    this.height = 500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.8),
            Colors.black,
          ],
        ),
      ),
    );
  }
}

/// Movie title and info widget
class MovieTitleInfoWidget extends StatelessWidget {
  final String title;
  final String releaseDate;
  final bool hasTrailer;
  final VoidCallback? onGetTickets;
  final VoidCallback? onWatchTrailer;

  const MovieTitleInfoWidget({
    Key? key,
    required this.title,
    required this.releaseDate,
    required this.hasTrailer,
    this.onGetTickets,
    this.onWatchTrailer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'In Theaters $releaseDate',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        if (hasTrailer) ...[
          ElevatedButton(
            onPressed: onGetTickets,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF61C3F2),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Get Tickets',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: onWatchTrailer,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Watch Trailer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Genre chips widget
class GenreChipsWidget extends StatelessWidget {
  final List<Genre> genres;

  const GenreChipsWidget({
    Key? key,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF15D2BC),  // Action
      const Color(0xFFE26CA5),  // Thriller
      const Color(0xFF564CA3),  // Science
      const Color(0xFFCD9D0F),  // Fiction
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        genres.length,
        (index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: colors[index % colors.length],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            genres[index].name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Movie overview widget
class MovieOverviewWidget extends StatelessWidget {
  final String overview;

  const MovieOverviewWidget({
    Key? key,
    required this.overview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          overview,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

/// Movie detail app bar widget
class MovieDetailAppBarWidget extends StatelessWidget {
  final VoidCallback? onBackPressed;

  const MovieDetailAppBarWidget({
    Key? key,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'Watch',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Movie content container widget
class MovieContentContainerWidget extends StatelessWidget {
  final Widget child;

  const MovieContentContainerWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}

/// Section title widget
class SectionTitleWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final double fontSize;

  const SectionTitleWidget({
    Key? key,
    required this.title,
    this.color = Colors.black,
    this.fontSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
} 