import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_theme.dart';
import '../constants/predefined_themes.dart';

class ThemeService extends ChangeNotifier {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  AppThemeData _currentTheme = PredefinedThemes.elDoradoGold;
  final StreamController<AppThemeData> _themeController =
      StreamController<AppThemeData>.broadcast();

  // Getters
  AppThemeData get currentTheme => _currentTheme;
  Stream<AppThemeData> get themeStream => _themeController.stream;

  // Initialize the service
  Future<void> initialize() async {
    await _loadTheme();
  }

  // Load theme from SharedPreferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeId = prefs.getString('selected_theme_id') ?? 'el_dorado_gold';

      final theme = PredefinedThemes.getThemeById(themeId);
      if (theme != null) {
        _currentTheme = theme;
        _themeController.add(_currentTheme);
        notifyListeners(); // Notify listeners of the loaded theme
      }
    } catch (e) {
      debugPrint('Error loading theme: $e');
      _currentTheme = PredefinedThemes.elDoradoGold;
      _themeController.add(_currentTheme);
      notifyListeners(); // Notify listeners of the fallback theme
    }
  }

  // Save theme to SharedPreferences
  Future<void> _saveTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_theme_id', _currentTheme.id);
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  // Change theme
  Future<void> changeTheme(AppThemeData theme) async {
    if (_currentTheme.id == theme.id) return;

    _currentTheme = theme;
    _themeController.add(_currentTheme);
    notifyListeners(); // Notify listeners of the change
    await _saveTheme();

    // Haptic feedback
    HapticFeedback.lightImpact();
  }

  // Get all available themes
  List<AppThemeData> getAvailableThemes() {
    return PredefinedThemes.allThemes;
  }

  // Get themes by type
  List<AppThemeData> getThemesByType(ThemeType type) {
    return PredefinedThemes.getThemesByType(type);
  }

  // Get free themes
  List<AppThemeData> getFreeThemes() {
    return PredefinedThemes.getFreeThemes();
  }

  // Get premium themes
  List<AppThemeData> getPremiumThemes() {
    return PredefinedThemes.getPremiumThemes();
  }

  // Convert AppThemeData to Flutter ThemeData
  ThemeData toFlutterTheme() {
    final colors = _currentTheme.colors;
    final gradients = _currentTheme.gradients;
    final shadows = _currentTheme.shadows;

    return ThemeData(
      useMaterial3: true,
      brightness: _currentTheme.type == ThemeType.dark ? Brightness.dark : Brightness.light,
      
      // Color scheme
      colorScheme: ColorScheme(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
        background: colors.background,
        error: colors.error,
        onPrimary: colors.onPrimary,
        onSecondary: colors.onSecondary,
        onSurface: colors.onSurface,
        onBackground: colors.onBackground,
        onError: colors.onPrimary,
        brightness: _currentTheme.type == ThemeType.dark ? Brightness.dark : Brightness.light,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 2,
        shadowColor: colors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 2,
          shadowColor: colors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(0, 48),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.borderFocused, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: colors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: colors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: colors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: colors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: colors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: colors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: colors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: colors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: colors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: colors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: colors.textPrimary,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: colors.textSecondary,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: colors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: colors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: colors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.background,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
        space: 1,
      ),

      // Icon theme
      iconTheme: IconThemeData(
        color: colors.textPrimary,
        size: 24,
      ),

      // Primary icon theme
      primaryIconTheme: IconThemeData(
        color: colors.onPrimary,
        size: 24,
      ),
    );
  }

  // Dispose
  void dispose() {
    _themeController.close();
  }
}
