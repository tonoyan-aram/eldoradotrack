import 'package:flutter/material.dart';
import '../models/app_theme.dart';

class PredefinedThemes {
  // El Dorado Gold Theme (Default)
  static const AppThemeData elDoradoGold = AppThemeData(
    id: 'el_dorado_gold',
    name: 'El Dorado Gold',
    description: 'Classic golden treasure theme',
    icon: '🏆',
    type: ThemeType.light,
    isCustom: false,
    isPremium: false,
    colors: AppThemeColors(
      primary: Color(0xFFFFD700), // Gold
      secondary: Color(0xFF2E7D32), // Dark Green
      background: Color(0xFFFFF8E1), // Cream
      surface: Color(0xFFFFF3C4), // Light Gold
      onPrimary: Color(0xFF1B5E20), // Dark Green
      onSecondary: Color(0xFFFFFFFF), // White
      onBackground: Color(0xFF1B5E20), // Dark Green
      onSurface: Color(0xFF1B5E20), // Dark Green
      error: Color(0xFFD32F2F), // Red
      success: Color(0xFF4CAF50), // Green
      warning: Color(0xFFFF9800), // Orange
      info: Color(0xFF2196F3), // Blue
      textPrimary: Color(0xFF1B5E20), // Dark Green
      textSecondary: Color(0xFF558B2F), // Medium Green
      textDisabled: Color(0xFF81C784), // Light Green
      border: Color(0xFFFFE082), // Light Gold
      borderFocused: Color(0xFFFFD700), // Gold
      shadow: Color(0x1AFFD700), // Gold with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFFFFD700), Color(0xFFFFF59D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFF3C4)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFFFFF3C4), Color(0xFFFFE082)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1AFFD700),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1AFFD700),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1AFFD700),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1AFFD700),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Emerald Forest Theme
  static const AppThemeData emeraldForest = AppThemeData(
    id: 'emerald_forest',
    name: 'Emerald Forest',
    description: 'Rich emerald and forest green theme',
    icon: '🌲',
    type: ThemeType.light,
    isCustom: false,
    isPremium: false,
    colors: AppThemeColors(
      primary: Color(0xFF00C853), // Emerald Green
      secondary: Color(0xFFFFD700), // Gold
      background: Color(0xFFF1F8E9), // Light Green
      surface: Color(0xFFE8F5E8), // Very Light Green
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFF1B5E20), // Dark Green
      onBackground: Color(0xFF1B5E20), // Dark Green
      onSurface: Color(0xFF1B5E20), // Dark Green
      error: Color(0xFFD32F2F), // Red
      success: Color(0xFF00C853), // Emerald
      warning: Color(0xFFFF9800), // Orange
      info: Color(0xFF2196F3), // Blue
      textPrimary: Color(0xFF1B5E20), // Dark Green
      textSecondary: Color(0xFF2E7D32), // Medium Green
      textDisabled: Color(0xFF81C784), // Light Green
      border: Color(0xFFC8E6C9), // Light Green
      borderFocused: Color(0xFF00C853), // Emerald
      shadow: Color(0x1A00C853), // Emerald with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFF00C853), Color(0xFF4CAF50)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFFFFD700), Color(0xFFFFF59D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFFF1F8E9), Color(0xFFE8F5E8)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFFE8F5E8), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1A00C853),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1A00C853),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1A00C853),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1A00C853),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Ancient Treasure Theme
  static const AppThemeData ancientTreasure = AppThemeData(
    id: 'ancient_treasure',
    name: 'Ancient Treasure',
    description: 'Mysterious bronze and copper theme',
    icon: '🏺',
    type: ThemeType.dark,
    isCustom: false,
    isPremium: true,
    colors: AppThemeColors(
      primary: Color(0xFFFFB74D), // Bronze
      secondary: Color(0xFF8D6E63), // Brown
      background: Color(0xFF3E2723), // Dark Brown
      surface: Color(0xFF5D4037), // Medium Brown
      onPrimary: Color(0xFF1B5E20), // Dark Green
      onSecondary: Color(0xFFFFFFFF), // White
      onBackground: Color(0xFFFFB74D), // Bronze
      onSurface: Color(0xFFFFB74D), // Bronze
      error: Color(0xFFEF5350), // Light Red
      success: Color(0xFF66BB6A), // Light Green
      warning: Color(0xFFFFB74D), // Bronze
      info: Color(0xFF42A5F5), // Light Blue
      textPrimary: Color(0xFFFFB74D), // Bronze
      textSecondary: Color(0xFFFFCC80), // Light Bronze
      textDisabled: Color(0xFF8D6E63), // Brown
      border: Color(0xFF8D6E63), // Brown
      borderFocused: Color(0xFFFFB74D), // Bronze
      shadow: Color(0x1AFFB74D), // Bronze with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFFFFB74D), Color(0xFFFFCC80)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFF8D6E63), Color(0xFFA1887F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFF3E2723), Color(0xFF5D4037)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFF5D4037), Color(0xFF8D6E63)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1AFFB74D),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1AFFB74D),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1AFFB74D),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1AFFB74D),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Royal Purple Theme
  static const AppThemeData royalPurple = AppThemeData(
    id: 'royal_purple',
    name: 'Royal Purple',
    description: 'Luxurious purple and gold theme',
    icon: '👑',
    type: ThemeType.dark,
    isCustom: false,
    isPremium: true,
    colors: AppThemeColors(
      primary: Color(0xFF9C27B0), // Purple
      secondary: Color(0xFFFFD700), // Gold
      background: Color(0xFF1A1A2E), // Dark Purple
      surface: Color(0xFF16213E), // Medium Purple
      onPrimary: Color(0xFFFFFFFF), // White
      onSecondary: Color(0xFF1B5E20), // Dark Green
      onBackground: Color(0xFFFFD700), // Gold
      onSurface: Color(0xFFFFD700), // Gold
      error: Color(0xFFEF5350), // Light Red
      success: Color(0xFF66BB6A), // Light Green
      warning: Color(0xFFFFB74D), // Orange
      info: Color(0xFF42A5F5), // Light Blue
      textPrimary: Color(0xFFFFD700), // Gold
      textSecondary: Color(0xFFBA68C8), // Light Purple
      textDisabled: Color(0xFF9C27B0), // Purple
      border: Color(0xFF9C27B0), // Purple
      borderFocused: Color(0xFFFFD700), // Gold
      shadow: Color(0x1A9C27B0), // Purple with opacity
    ),
    gradients: AppThemeGradients(
      primary: LinearGradient(
        colors: [Color(0xFF9C27B0), Color(0xFFE1BEE7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondary: LinearGradient(
        colors: [Color(0xFFFFD700), Color(0xFFFFF59D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      background: LinearGradient(
        colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      surface: LinearGradient(
        colors: [Color(0xFF16213E), Color(0xFF9C27B0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    shadows: AppThemeShadows(
      small: [
        BoxShadow(
          color: Color(0x1A9C27B0),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      medium: [
        BoxShadow(
          color: Color(0x1A9C27B0),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
      large: [
        BoxShadow(
          color: Color(0x1A9C27B0),
          offset: Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
      card: [
        BoxShadow(
          color: Color(0x1A9C27B0),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ],
    ),
  );

  // Get all predefined themes
  static List<AppThemeData> get allThemes => [
    elDoradoGold,
    emeraldForest,
    ancientTreasure,
    royalPurple,
  ];

  // Get themes by type
  static List<AppThemeData> getThemesByType(ThemeType type) {
    return allThemes.where((theme) => theme.type == type).toList();
  }

  // Get premium themes
  static List<AppThemeData> getPremiumThemes() {
    return allThemes.where((theme) => theme.isPremium).toList();
  }

  // Get free themes
  static List<AppThemeData> getFreeThemes() {
    return allThemes.where((theme) => !theme.isPremium).toList();
  }

  // Get theme by ID
  static AppThemeData? getThemeById(String id) {
    try {
      return allThemes.firstWhere((theme) => theme.id == id);
    } catch (e) {
      return null;
    }
  }
}

