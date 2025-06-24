import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'movie_list_viewmodel.dart';
import '../../../app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../widgets/movie_list_widgets.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MovieListViewModel>.reactive(
      viewModelBuilder: () => MovieListViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.upcomingMoviesTitle),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => model.navigateToSearchScreen(),
              ),
            ],
          ),
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: model.isBusy
                      ? const MovieListLoadingWidget()
                      : model.hasError
                          ? MovieListErrorWidget(error: model.error.toString())
                          : MovieListWidget(model: model, context: context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 