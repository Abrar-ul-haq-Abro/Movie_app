import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'booking_viewmodel.dart';
import '../../../models/movie_detail.dart';

class BookingScreen extends StatelessWidget {
  final MovieDetail movie;
  const BookingScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingViewModel>.reactive(
      viewModelBuilder: () => BookingViewModel(),
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
                Text(AppStrings.inTheaters(movie.releaseDate), style: const TextStyle(color: AppColors.textLink, fontSize: 14)),
              ],
            ),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(AppStrings.dateTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: model.dates.length,
                  itemBuilder: (context, index) {
                    final date = model.dates[index];
                    final isSelected = date.day == model.selectedDate.day;
                    return GestureDetector(
                      onTap: () => model.selectDate(date),
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
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    _ShowtimeCard(time: '12:30', hall: 'Cinetech + Hall 1', price: 50, bonus: 2500, isSelected: true),
                    _ShowtimeCard(time: '13:30', hall: 'Cinetech + Hall 2', price: 75, bonus: 3000, isSelected: false),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => model.navigateToSeatSelection(movie: movie),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(AppStrings.selectSeatsButton, style: TextStyle(fontSize: 18, color: AppColors.textLight)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _ShowtimeCard extends StatelessWidget {
  final String time;
  final String hall;
  final int price;
  final int bonus;
  final bool isSelected;

  const _ShowtimeCard({
    required this.time,
    required this.hall,
    required this.price,
    required this.bonus,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(time, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text(hall, style: TextStyle(color: AppColors.textGrey)),
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
                TextSpan(text: AppStrings.fromPrice(50)),
                TextSpan(text: AppStrings.orBonus(2500)),
              ],
            ),
          )
        ],
      ),
    );
  }
}