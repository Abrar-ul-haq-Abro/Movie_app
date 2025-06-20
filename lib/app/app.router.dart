// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i7;
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart' as _i8;
import 'package:movie_app/models/movie_detail.dart' as _i9;
import 'package:movie_app/ui/views/booking/booking_view.dart' as _i5;
import 'package:movie_app/ui/views/movie_detail/movie_detail_screen.dart'
    as _i3;
import 'package:movie_app/ui/views/movie_list/movie_list_view.dart' as _i2;
import 'package:movie_app/ui/views/movie_search/movie_search_view.dart' as _i4;
import 'package:movie_app/ui/views/seat_selection/seat_selection_view.dart'
    as _i6;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const movieListView = '/';

  static const movieDetailScreen = '/movie-detail';

  static const movieSearchScreen = '/movie-search';

  static const bookingScreen = '/booking';

  static const seatSelectionScreen = '/seat-selection';

  static const all = <String>{
    movieListView,
    movieDetailScreen,
    movieSearchScreen,
    bookingScreen,
    seatSelectionScreen,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.movieListView,
      page: _i2.MovieListView,
    ),
    _i1.RouteDef(
      Routes.movieDetailScreen,
      page: _i3.MovieDetailScreen,
    ),
    _i1.RouteDef(
      Routes.movieSearchScreen,
      page: _i4.MovieSearchScreen,
    ),
    _i1.RouteDef(
      Routes.bookingScreen,
      page: _i5.BookingScreen,
    ),
    _i1.RouteDef(
      Routes.seatSelectionScreen,
      page: _i6.SeatSelectionScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.MovieListView: (data) {
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.MovieListView(),
        settings: data,
      );
    },
    _i3.MovieDetailScreen: (data) {
      final args = data.getArgs<MovieDetailScreenArguments>(nullOk: false);
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.MovieDetailScreen(key: args.key, movieId: args.movieId),
        settings: data,
      );
    },
    _i4.MovieSearchScreen: (data) {
      final args = data.getArgs<MovieSearchScreenArguments>(nullOk: false);
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.MovieSearchScreen(key: args.key, movies: args.movies),
        settings: data,
      );
    },
    _i5.BookingScreen: (data) {
      final args = data.getArgs<BookingScreenArguments>(nullOk: false);
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.BookingScreen(key: args.key, movie: args.movie),
        settings: data,
      );
    },
    _i6.SeatSelectionScreen: (data) {
      final args = data.getArgs<SeatSelectionScreenArguments>(nullOk: false);
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.SeatSelectionScreen(
            key: args.key,
            movie: args.movie,
            selectedDate: args.selectedDate,
            selectedTime: args.selectedTime),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class MovieDetailScreenArguments {
  const MovieDetailScreenArguments({
    this.key,
    required this.movieId,
  });

  final _i7.Key? key;

  final int movieId;

  @override
  String toString() {
    return '{"key": "$key", "movieId": "$movieId"}';
  }

  @override
  bool operator ==(covariant MovieDetailScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.movieId == movieId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ movieId.hashCode;
  }
}

class MovieSearchScreenArguments {
  const MovieSearchScreenArguments({
    this.key,
    required this.movies,
  });

  final _i7.Key? key;

  final List<_i8.Movie> movies;

  @override
  String toString() {
    return '{"key": "$key", "movies": "$movies"}';
  }

  @override
  bool operator ==(covariant MovieSearchScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.movies == movies;
  }

  @override
  int get hashCode {
    return key.hashCode ^ movies.hashCode;
  }
}

class BookingScreenArguments {
  const BookingScreenArguments({
    this.key,
    required this.movie,
  });

  final _i7.Key? key;

  final _i9.MovieDetail movie;

  @override
  String toString() {
    return '{"key": "$key", "movie": "$movie"}';
  }

  @override
  bool operator ==(covariant BookingScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.movie == movie;
  }

  @override
  int get hashCode {
    return key.hashCode ^ movie.hashCode;
  }
}

class SeatSelectionScreenArguments {
  const SeatSelectionScreenArguments({
    this.key,
    required this.movie,
    required this.selectedDate,
    required this.selectedTime,
  });

  final _i7.Key? key;

  final _i9.MovieDetail movie;

  final String selectedDate;

  final String selectedTime;

  @override
  String toString() {
    return '{"key": "$key", "movie": "$movie", "selectedDate": "$selectedDate", "selectedTime": "$selectedTime"}';
  }

  @override
  bool operator ==(covariant SeatSelectionScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.movie == movie &&
        other.selectedDate == selectedDate &&
        other.selectedTime == selectedTime;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        movie.hashCode ^
        selectedDate.hashCode ^
        selectedTime.hashCode;
  }
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToMovieListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.movieListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMovieDetailScreen({
    _i7.Key? key,
    required int movieId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.movieDetailScreen,
        arguments: MovieDetailScreenArguments(key: key, movieId: movieId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMovieSearchScreen({
    _i7.Key? key,
    required List<_i8.Movie> movies,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.movieSearchScreen,
        arguments: MovieSearchScreenArguments(key: key, movies: movies),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBookingScreen({
    _i7.Key? key,
    required _i9.MovieDetail movie,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bookingScreen,
        arguments: BookingScreenArguments(key: key, movie: movie),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSeatSelectionScreen({
    _i7.Key? key,
    required _i9.MovieDetail movie,
    required String selectedDate,
    required String selectedTime,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.seatSelectionScreen,
        arguments: SeatSelectionScreenArguments(
            key: key,
            movie: movie,
            selectedDate: selectedDate,
            selectedTime: selectedTime),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMovieListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.movieListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMovieDetailScreen({
    _i7.Key? key,
    required int movieId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.movieDetailScreen,
        arguments: MovieDetailScreenArguments(key: key, movieId: movieId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMovieSearchScreen({
    _i7.Key? key,
    required List<_i8.Movie> movies,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.movieSearchScreen,
        arguments: MovieSearchScreenArguments(key: key, movies: movies),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBookingScreen({
    _i7.Key? key,
    required _i9.MovieDetail movie,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bookingScreen,
        arguments: BookingScreenArguments(key: key, movie: movie),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSeatSelectionScreen({
    _i7.Key? key,
    required _i9.MovieDetail movie,
    required String selectedDate,
    required String selectedTime,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.seatSelectionScreen,
        arguments: SeatSelectionScreenArguments(
            key: key,
            movie: movie,
            selectedDate: selectedDate,
            selectedTime: selectedTime),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
