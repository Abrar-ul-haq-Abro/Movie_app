import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import 'booking_viewmodel.dart';
import '../../../models/movie_detail.dart';
import '../../widgets/booking_widgets.dart';

class BookingScreen extends StatelessWidget {
  final MovieDetail movie;
  const BookingScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingViewModel>.reactive(
      viewModelBuilder: () => BookingViewModel(),
      onViewModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) {
        // Create showtime data for the widgets
        final showtimes = [
          const ShowtimeData(
            time: '12:30',
            hall: 'Cinetech + Hall 1',
            price: 50,
            bonus: 2500,
          ),
          const ShowtimeData(
            time: '13:30',
            hall: 'Cinetech + Hall 2',
            price: 75,
            bonus: 3000,
          ),
        ];

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: BookingAppBarWidget(movie: movie),
          body: BookingContentWidget(
            dates: model.dates,
            selectedDate: model.selectedDate,
            onDateSelected: model.selectDate,
            showtimes: showtimes,
            selectedShowtimeIndex: 0, // You can add this to your view model
            onShowtimeSelected: (index) {
              // Handle showtime selection
              print('Selected showtime index: $index');
            },
            onSelectSeats: () => model.navigateToSeatSelection(movie: movie),
          ),
        );
      },
    );
  }
}