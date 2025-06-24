import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import 'seat_selection_viewmodel.dart';
import '../../../models/movie_detail.dart';
import '../../widgets/seat_selection_widgets.dart';

class SeatSelectionScreen extends StatelessWidget {
  final MovieDetail movie;
  final String selectedDate;
  final String selectedTime;
  
  const SeatSelectionScreen({
    Key? key,
    required this.movie,
    required this.selectedDate,
    required this.selectedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SeatSelectionViewModel>.reactive(
      viewModelBuilder: () => SeatSelectionViewModel(),
      onViewModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: SeatSelectionAppBarWidget(
            movie: movie,
            selectedDate: selectedDate,
            selectedTime: selectedTime,
          ),
          body: SeatSelectionContentWidget(
            seatLayout: model.seatLayout,
            onSeatSelected: model.selectSeat,
            selectedSeatsCount: model.selectedSeats.length,
            totalPrice: model.totalPrice,
            onProceedToPay: () {
              // To be implemented
              print('Proceed to pay button pressed');
            },
          ),
        );
      },
    );
  }
} 