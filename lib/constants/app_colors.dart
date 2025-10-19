import 'package:flutter/material.dart';

class AppColors {
  // Brand colors: золотой, темно-зеленый, кремовый
  static const Color primary = Color(0xFFFFD700); // Gold
  static const Color secondary = Color(0xFF2E7D32); // Dark Green
  static const Color background = Color(0xFFFFF8E1); // Cream
  static const Color surface = Color(0xFFFFF3C4); // Light Gold
  static const Color onPrimary = Color(0xFF1B5E20); // Dark Green
  static const Color onSecondary = Color(0xFFFFFFFF); // White
  static const Color onBackground = Color(0xFF1B5E20); // Dark Green
  static const Color onSurface = Color(0xFF1B5E20); // Dark Green
  
  // Additional colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Text colors
  static const Color textPrimary = Color(0xFF1B5E20);
  static const Color textSecondary = Color(0xFF558B2F);
  static const Color textDisabled = Color(0xFF81C784);
  
  // Border colors
  static const Color border = Color(0xFFFFE082);
  static const Color borderFocused = primary;
  
  // Shadow colors
  static const Color shadow = Color(0x1AFFD700);
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFFFF59D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient treasureGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFA000), Color(0xFFFF8F00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient forestGradient = LinearGradient(
    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50), Color(0xFF8BC34A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Treasure type colors
  static const Map<String, Color> treasureColors = {
    'gold': Color(0xFFFFD700),
    'jewelry': Color(0xFF9C27B0),
    'artifacts': Color(0xFF795548),
    'coins': Color(0xFFFFC107),
    'gems': Color(0xFFE91E63),
    'other': Color(0xFF607D8B),
  };
  
  // Level colors
  static const List<Color> levelColors = [
    Color(0xFF8D6E63), // Brown - Level 1
    Color(0xFF795548), // Dark Brown - Level 2
    Color(0xFF607D8B), // Blue Grey - Level 3
    Color(0xFF455A64), // Dark Blue Grey - Level 4
    Color(0xFF37474F), // Darker Blue Grey - Level 5
    Color(0xFF263238), // Almost Black - Level 6+
  ];
}

