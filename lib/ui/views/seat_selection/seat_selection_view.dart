import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'seat_selection_viewmodel.dart';
import '../../../models/movie_detail.dart';


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
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: const BackButton(color: AppColors.textDark),
            title: Column(
              children: [
                Text(movie.title, style: const TextStyle(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('$selectedDate | $selectedTime ${AppStrings.hall(1)}', style: const TextStyle(color: AppColors.textLink, fontSize: 14)),
              ],
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              _buildScreenWidget(),
              Expanded(
                child: InteractiveViewer(
                  maxScale: 5.0,
                  minScale: 0.8,
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: model.seatLayout.map((row) {
                          return Row(
                            children: row.map((seat) {
                              return GestureDetector(
                                onTap: () => model.selectSeat(seat),
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: _getSeatColor(seat.type),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              _buildLegend(context),
              _buildBookingSummary(context, model),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScreenWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Text(AppStrings.screen),
          CustomPaint(
            size: const Size(double.infinity, 20),
            painter: ScreenCurvePainter(),
          ),
        ],
      ),
    );
  }

  Color _getSeatColor(SeatType type) {
    switch (type) {
      case SeatType.available:
        return AppColors.seatAvailable;
      case SeatType.unavailable:
        return AppColors.seatUnavailable;
      case SeatType.selected:
        return AppColors.seatSelected;
      case SeatType.vip:
        return AppColors.seatVip;
      default:
        return AppColors.textGrey;
    }
  }
  
  Widget _buildLegend(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: _buildLegendItem(AppColors.seatSelected, AppStrings.legendSelected)),
              Expanded(child: _buildLegendItem(AppColors.seatUnavailable, AppStrings.legendNotAvailable)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildLegendItem(AppColors.seatVip, AppStrings.legendVip)),
              Expanded(child: _buildLegendItem(AppColors.seatAvailable, AppStrings.legendRegular)),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
  
  Widget _buildBookingSummary(BuildContext context, SeatSelectionViewModel model) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.textGrey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.seats(model.selectedSeats.length)),
              Text(AppStrings.totalPrice(model.totalPrice)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {}, // To be implemented
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(AppStrings.proceedToPayButton, style: TextStyle(fontSize: 18, color: AppColors.textLight)),
          ),
        ],
      ),
    );
  }
}

class ScreenCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.seatUnavailable
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, -size.height, size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
} 