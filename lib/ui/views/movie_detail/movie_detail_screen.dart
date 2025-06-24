import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../models/movie_detail.dart';
import 'movie_detail_viewmodel.dart';
import '../../widgets/movie_detail_widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MovieDetailViewModel>.reactive(
      viewModelBuilder: () => MovieDetailViewModel(),
      onViewModelReady: (model) => model.init(movieId),
      builder: (context, model, child) {
        if (model.isBusy) {
          return const MovieDetailLoadingWidget();
        }

        if (model.hasError) {
          return MovieDetailErrorWidget(errorMessage: model.errorMessage);
        }

        final movie = model.movieDetail;
        if (movie == null) return const Scaffold(backgroundColor: Colors.black);

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        MovieBackdropWidget(imageUrl: movie.fullBackdropPath),
                        const MovieBackdropGradientWidget(),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: MovieTitleInfoWidget(
                            title: movie.title,
                            releaseDate: movie.releaseDate,
                            hasTrailer: model.hasTrailer,
                            onGetTickets: model.navigateToBooking,
                            onWatchTrailer: model.hasTrailer ? () {
                              print('Trailer button pressed!');
                              print('Has trailer: ${model.hasTrailer}');
                              print('Videos count: ${model.videos.length}');
                              model.playTrailer(context);
                            } : null,
                          ),
                        ),
                      ],
                    ),
                    MovieContentContainerWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitleWidget(title: 'Genres'),
                          const SizedBox(height: 12),
                          GenreChipsWidget(genres: movie.genres),
                          const SizedBox(height: 24),
                          MovieOverviewWidget(overview: movie.overview),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const MovieDetailAppBarWidget(),
            ],
          ),
        );
      },
    );
  }
} 