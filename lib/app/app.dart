import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../ui/views/movie_detail/movie_detail_screen.dart';
import '../ui/views/movie_list/movie_list_view.dart';
import '../ui/views/movie_search/movie_search_view.dart';
import '../ui/views/booking/booking_view.dart';
import '../ui/views/seat_selection/seat_selection_view.dart';


@StackedApp(
  routes: [
    MaterialRoute(page: MovieListView, initial: true),
    MaterialRoute(page: MovieDetailScreen, path: '/movie-detail'),
    MaterialRoute(page: MovieSearchScreen, path: '/movie-search'),
    MaterialRoute(page: BookingScreen, path: '/booking'),
    MaterialRoute(page: SeatSelectionScreen, path: '/seat-selection'),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AppColors),
    LazySingleton(classType: AppStrings),
  ],
)
class App {} 