class AppStrings {
  // Singleton setup
  AppStrings._privateConstructor();
  static final AppStrings _instance = AppStrings._privateConstructor();
  factory AppStrings() => _instance;

  // General
  static const String appName = 'Movie App';
  
  // Movie List Screen
  static const String upcomingMoviesTitle = 'Upcoming Movies';
  static const String watchTitle = 'Watch';
  static const String searchHint = 'Search movies';

  // Movie Search Screen
  static const String topResults = 'Top Results';
  static String resultsFound(int count) => '$count Results Found';
  static const String placeholderGenre = 'Sci-Fi';

  // Movie Detail Screen
  static String inTheaters(String date) => 'In Theaters $date';
  static const String getTicketsButton = 'Get Tickets';
  static const String watchTrailerButton = 'Watch Trailer';
  static const String genresTitle = 'Genres';
  static const String overviewTitle = 'Overview';
  
  // Booking Screen
  static const String dateTitle = 'Date';
  static const String selectSeatsButton = 'Select Seats';
  static String fromPrice(int price) => 'From \$$price';
  static String orBonus(int bonus) => ' or $bonus bonus';
  
  // Seat Selection Screen
  static String hall(int number) => 'Hall $number';
  static const String screen = 'SCREEN';
  static const String legendSelected = 'Selected';
  static const String legendNotAvailable = 'Not available';
  static const String legendVip = 'VIP (\$150)';
  static const String legendRegular = 'Regular (\$50)';
  static String seats(int count) => '$count seats';
  static String totalPrice(double price) => 'Total: \$${price.toStringAsFixed(0)}';
  static const String proceedToPayButton = 'Proceed to pay';

  // Error Messages
  static String errorLoadingMovies(String error) => 'Error loading movies:\n$error';
} 