class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'e8af7a3c78144570b857554a56c513cf';
  
  // API Endpoints
  static const String upcomingMovies = '/movie/upcoming';
  static String movieDetails(int movieId) => '/movie/$movieId';
  static String movieImages(int movieId) => '/movie/$movieId/images';
  static String movieVideos(int movieId) => '/movie/$movieId/videos';
  
  // Image URLs
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String imageOriginalBaseUrl = 'https://image.tmdb.org/t/p/original';

  // Query Parameters
  static Map<String, dynamic> get defaultQueryParams => {
    'api_key': apiKey,
    'language': 'en-US',
    'page': 1,
  };
} 