import 'package:stacked/stacked.dart';
import '../../../models/movie.dart';
import '../../../services/movie_service_mixin.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class MovieListViewModel extends BaseViewModel with MovieServiceMixin {
  final _navigationService = locator<NavigationService>();
  List<Movie> movies = [];
  
  Future<void> init() async {
    setBusy(true);
    try {
      movies = await getUpcomingMovies();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void navigateToMovieDetail(int movieId) {
    _navigationService.navigateToMovieDetailScreen(movieId: movieId);
  }

  void navigateToSearchScreen() {
    _navigationService.navigateToMovieSearchScreen(movies: movies);
  }
} 