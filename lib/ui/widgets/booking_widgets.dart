import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/movie_detail.dart';

/// Showtime card widget
class ShowtimeCard extends StatelessWidget {
  final String time;
  final String hall;
  final int price;
  final int bonus;
  final bool isSelected;
  final VoidCallback? onTap;

  const ShowtimeCard({
    Key? key,
    required this.time,
    required this.hall,
    required this.price,
    required this.bonus,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.shimmerBase),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  time, 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
                const SizedBox(width: 8),
                Text(
                  hall, 
                  style: TextStyle(color: AppColors.textGrey)
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: Image.asset('assets/Frame_th.png'),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: AppColors.textDark, fontSize: 16),
                children: [
                  TextSpan(text: AppStrings.fromPrice(price)),
                  TextSpan(text: AppStrings.orBonus(bonus)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Booking app bar widget
class BookingAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final MovieDetail movie;
  final VoidCallback? onBackPressed;

  const BookingAppBarWidget({
    Key? key,
    required this.movie,
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
            AppStrings.inTheaters(movie.releaseDate), 
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

/// Date selection widget
class DateSelectionWidget extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DateSelectionWidget({
    Key? key,
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            AppStrings.dateTitle, 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected = date.day == selectedDate.day;
              return DateCardWidget(
                date: date,
                isSelected: isSelected,
                onTap: () => onDateSelected(date),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Individual date card widget
class DateCardWidget extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateCardWidget({
    Key? key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.shimmerBase,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            DateFormat('d MMM').format(date),
            style: TextStyle(
              color: isSelected ? AppColors.textLight : AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

/// Showtime selection widget
class ShowtimeSelectionWidget extends StatelessWidget {
  final List<ShowtimeData> showtimes;
  final int selectedShowtimeIndex;
  final Function(int) onShowtimeSelected;

  const ShowtimeSelectionWidget({
    Key? key,
    required this.showtimes,
    required this.selectedShowtimeIndex,
    required this.onShowtimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: showtimes.length,
        itemBuilder: (context, index) {
          final showtime = showtimes[index];
          return ShowtimeCard(
            time: showtime.time,
            hall: showtime.hall,
            price: showtime.price,
            bonus: showtime.bonus,
            isSelected: index == selectedShowtimeIndex,
            onTap: () => onShowtimeSelected(index),
          );
        },
      ),
    );
  }
}

/// Select seats button widget
class SelectSeatsButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SelectSeatsButtonWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          AppStrings.selectSeatsButton, 
          style: TextStyle(fontSize: 18, color: AppColors.textLight)
        ),
      ),
    );
  }
}

/// Showtime data model
class ShowtimeData {
  final String time;
  final String hall;
  final int price;
  final int bonus;

  const ShowtimeData({
    required this.time,
    required this.hall,
    required this.price,
    required this.bonus,
  });
}

/// Booking content widget
class BookingContentWidget extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final List<ShowtimeData> showtimes;
  final int selectedShowtimeIndex;
  final Function(int) onShowtimeSelected;
  final VoidCallback onSelectSeats;

  const BookingContentWidget({
    Key? key,
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
    required this.showtimes,
    required this.selectedShowtimeIndex,
    required this.onShowtimeSelected,
    required this.onSelectSeats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateSelectionWidget(
          dates: dates,
          selectedDate: selectedDate,
          onDateSelected: onDateSelected,
        ),
        const SizedBox(height: 24),
        ShowtimeSelectionWidget(
          showtimes: showtimes,
          selectedShowtimeIndex: selectedShowtimeIndex,
          onShowtimeSelected: onShowtimeSelected,
        ),
        const Spacer(),
        SelectSeatsButtonWidget(onPressed: onSelectSeats),
      ],
    );
  }
} 