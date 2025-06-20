import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/movie_detail.dart';

class BookingViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  
  List<DateTime> _dates = [];
  List<DateTime> get dates => _dates;
  
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  
  String _selectedTime = "12:30";
  String get selectedTime => _selectedTime;

  void onModelReady() {
    _dates = List.generate(10, (index) => DateTime.now().add(Duration(days: index)));
    _selectedDate = _dates.first;
    notifyListeners();
  }
  
  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
  
  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  String get formattedDate => DateFormat('d MMM').format(_selectedDate);

  void navigateToSeatSelection({required MovieDetail movie}) {
    _navigationService.navigateToSeatSelectionScreen(
      movie: movie,
      selectedDate: formattedDate,
      selectedTime: selectedTime,
    );
  }
} 