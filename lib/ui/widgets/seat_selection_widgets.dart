import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/movie_detail.dart';
import '../views/seat_selection/seat_selection_viewmodel.dart';

/// Seat selection app bar widget
class SeatSelectionAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final MovieDetail movie;
  final String selectedDate;
  final String selectedTime;
  final VoidCallback? onBackPressed;

  const SeatSelectionAppBarWidget({
    Key? key,
    required this.movie,
    required this.selectedDate,
    required this.selectedTime,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: BackButton(
        color: AppColors.textDark,
        onPressed: onBackPressed,
      ),
      title: Column(
        children: [
          Text(
            movie.title, 
            style: const TextStyle(
              color: AppColors.textDark, 
              fontSize: 18, 
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 4),
          Text(
            '$selectedDate | $selectedTime ${AppStrings.hall(1)}', 
            style: const TextStyle(
              color: AppColors.textLink, 
              fontSize: 14
            )
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Screen widget
class ScreenWidget extends StatelessWidget {
  const ScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

/// Seat layout widget
class SeatLayoutWidget extends StatelessWidget {
  final List<List<Seat>> seatLayout;
  final Function(Seat) onSeatSelected;

  const SeatLayoutWidget({
    Key? key,
    required this.seatLayout,
    required this.onSeatSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InteractiveViewer(
        maxScale: 5.0,
        minScale: 0.8,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: seatLayout.map((row) {
                return Row(
                  children: row.map((seat) {
                    return SeatWidget(
                      seat: seat,
                      onTap: () => onSeatSelected(seat),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Individual seat widget
class SeatWidget extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;

  const SeatWidget({
    Key? key,
    required this.seat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
}

/// Legend widget
class SeatLegendWidget extends StatelessWidget {
  const SeatLegendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: LegendItemWidget(
                  color: AppColors.seatSelected,
                  text: AppStrings.legendSelected,
                ),
              ),
              Expanded(
                child: LegendItemWidget(
                  color: AppColors.seatUnavailable,
                  text: AppStrings.legendNotAvailable,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LegendItemWidget(
                  color: AppColors.seatVip,
                  text: AppStrings.legendVip,
                ),
              ),
              Expanded(
                child: LegendItemWidget(
                  color: AppColors.seatAvailable,
                  text: AppStrings.legendRegular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Individual legend item widget
class LegendItemWidget extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItemWidget({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 16, 
          height: 16, 
          color: color
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

/// Booking summary widget
class BookingSummaryWidget extends StatelessWidget {
  final int selectedSeatsCount;
  final double totalPrice;
  final VoidCallback onProceedToPay;

  const BookingSummaryWidget({
    Key? key,
    required this.selectedSeatsCount,
    required this.totalPrice,
    required this.onProceedToPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text(AppStrings.seats(selectedSeatsCount)),
              Text(AppStrings.totalPrice(totalPrice)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onProceedToPay,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              AppStrings.proceedToPayButton, 
              style: TextStyle(fontSize: 18, color: AppColors.textLight)
            ),
          ),
        ],
      ),
    );
  }
}

/// Screen curve painter
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

/// Seat selection content widget
class SeatSelectionContentWidget extends StatelessWidget {
  final List<List<Seat>> seatLayout;
  final Function(Seat) onSeatSelected;
  final int selectedSeatsCount;
  final double totalPrice;
  final VoidCallback onProceedToPay;

  const SeatSelectionContentWidget({
    Key? key,
    required this.seatLayout,
    required this.onSeatSelected,
    required this.selectedSeatsCount,
    required this.totalPrice,
    required this.onProceedToPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ScreenWidget(),
        SeatLayoutWidget(
          seatLayout: seatLayout,
          onSeatSelected: onSeatSelected,
        ),
        const SeatLegendWidget(),
        BookingSummaryWidget(
          selectedSeatsCount: selectedSeatsCount,
          totalPrice: totalPrice,
          onProceedToPay: onProceedToPay,
        ),
      ],
    );
  }
} 