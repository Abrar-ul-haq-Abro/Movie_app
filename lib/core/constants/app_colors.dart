import 'package:flutter/material.dart';

class AppColors {
  // Singleton setup
  AppColors._privateConstructor();
  static final AppColors _instance = AppColors._privateConstructor();
  factory AppColors() => _instance;

  // Primary Colors
  static const Color primary = Color(0xFF61C3F2); // Light Blue
  static const Color secondary = Color(0xFF15D2BC); // Teal

  // Background Colors
  static const Color background = Colors.white;
  static const Color darkBackground = Color(0xFF1C1C1C);
  static const Color shimmerBase = Color(0xFFE0E0E0); // Grey 300
  static const Color shimmerHighlight = Color(0xFFF5F5F5); // Grey 100

  // Text Colors
  static const Color textDark = Colors.black;
  static const Color textLight = Colors.white;
  static const Color textGrey = Colors.grey;
  static const Color textLink = Colors.lightBlue;

  // Accent & Status Colors
  static const Color gold = Color(0xFFFFD700);
  static const Color error = Colors.red;
  static const Color orange = Colors.orange;

  // Genre Colors
  static const Color genreAction = Color(0xFF15D2BC);
  static const Color genreThriller = Color(0xFFE26CA5);
  static const Color genreScience = Color(0xFF564CA3);
  static const Color genreFiction = Color(0xFFCD9D0F);
  
  // Seat Colors
  static const Color seatAvailable = Color(0xFFB3E5FC); // Light Blue 200
  static const Color seatUnavailable = Color(0xFFE0E0E0); // Grey 300
  static const Color seatSelected = Colors.amber;
  static const Color seatVip = Color(0xFFCE93D8); // Purple 300
} 