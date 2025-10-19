import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_theme.g.dart';

enum ThemeType {
  @JsonValue('light')
  light,
  @JsonValue('dark')
  dark,
  @JsonValue('seasonal')
  seasonal,
  @JsonValue('custom')
  custom,
}

enum SeasonalTheme {
  @JsonValue('spring')
  spring,
  @JsonValue('summer')
  summer,
  @JsonValue('autumn')
  autumn,
  @JsonValue('winter')
  winter,
}

@JsonSerializable()
class AppThemeData {
  final String id;
  final String name;
  final String description;
  final String icon;
  final ThemeType type;
  final SeasonalTheme? seasonalType;
  final bool isCustom;
  final bool isPremium;
  final AppThemeColors colors;
  final AppThemeGradients gradients;
  final AppThemeShadows shadows;

  const AppThemeData({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.type,
    this.seasonalType,
    this.isCustom = false,
    this.isPremium = false,
    required this.colors,
    required this.gradients,
    required this.shadows,
  });

  factory AppThemeData.fromJson(Map<String, dynamic> json) =>
      _$AppThemeDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeDataToJson(this);

  AppThemeData copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    ThemeType? type,
    SeasonalTheme? seasonalType,
    bool? isCustom,
    bool? isPremium,
    AppThemeColors? colors,
    AppThemeGradients? gradients,
    AppThemeShadows? shadows,
  }) {
    return AppThemeData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      seasonalType: seasonalType ?? this.seasonalType,
      isCustom: isCustom ?? this.isCustom,
      isPremium: isPremium ?? this.isPremium,
      colors: colors ?? this.colors,
      gradients: gradients ?? this.gradients,
      shadows: shadows ?? this.shadows,
    );
  }
}

@JsonSerializable()
class AppThemeColors {
  @ColorConverter()
  final Color primary;
  @ColorConverter()
  final Color secondary;
  @ColorConverter()
  final Color background;
  @ColorConverter()
  final Color surface;
  @ColorConverter()
  final Color onPrimary;
  @ColorConverter()
  final Color onSecondary;
  @ColorConverter()
  final Color onBackground;
  @ColorConverter()
  final Color onSurface;
  @ColorConverter()
  final Color error;
  @ColorConverter()
  final Color success;
  @ColorConverter()
  final Color warning;
  @ColorConverter()
  final Color info;
  @ColorConverter()
  final Color textPrimary;
  @ColorConverter()
  final Color textSecondary;
  @ColorConverter()
  final Color textDisabled;
  @ColorConverter()
  final Color border;
  @ColorConverter()
  final Color borderFocused;
  @ColorConverter()
  final Color shadow;

  const AppThemeColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.onPrimary,
    required this.onSecondary,
    required this.onBackground,
    required this.onSurface,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.border,
    required this.borderFocused,
    required this.shadow,
  });

  factory AppThemeColors.fromJson(Map<String, dynamic> json) =>
      _$AppThemeColorsFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeColorsToJson(this);

  AppThemeColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? onPrimary,
    Color? onSecondary,
    Color? onBackground,
    Color? onSurface,
    Color? error,
    Color? success,
    Color? warning,
    Color? info,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? border,
    Color? borderFocused,
    Color? shadow,
  }) {
    return AppThemeColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
      onBackground: onBackground ?? this.onBackground,
      onSurface: onSurface ?? this.onSurface,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
      border: border ?? this.border,
      borderFocused: borderFocused ?? this.borderFocused,
      shadow: shadow ?? this.shadow,
    );
  }
}

@JsonSerializable()
class AppThemeGradients {
  @LinearGradientConverter()
  final LinearGradient primary;
  @LinearGradientConverter()
  final LinearGradient secondary;
  @LinearGradientConverter()
  final LinearGradient background;
  @LinearGradientConverter()
  final LinearGradient surface;

  const AppThemeGradients({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
  });

  factory AppThemeGradients.fromJson(Map<String, dynamic> json) =>
      _$AppThemeGradientsFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeGradientsToJson(this);
}

@JsonSerializable()
class AppThemeShadows {
  @BoxShadowConverter()
  final List<BoxShadow> small;
  @BoxShadowConverter()
  final List<BoxShadow> medium;
  @BoxShadowConverter()
  final List<BoxShadow> large;
  @BoxShadowConverter()
  final List<BoxShadow> card;

  const AppThemeShadows({
    required this.small,
    required this.medium,
    required this.large,
    required this.card,
  });

  factory AppThemeShadows.fromJson(Map<String, dynamic> json) =>
      _$AppThemeShadowsFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeShadowsToJson(this);
}

// Helper class for Color serialization
class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}

// Helper class for LinearGradient serialization
class LinearGradientConverter
    implements JsonConverter<LinearGradient, Map<String, dynamic>> {
  const LinearGradientConverter();

  @override
  LinearGradient fromJson(Map<String, dynamic> json) {
    return LinearGradient(
      colors: (json['colors'] as List).map((c) => Color(c as int)).toList(),
      begin: _parseAlignment(json['begin'] as String?),
      end: _parseAlignment(json['end'] as String?),
    );
  }

  @override
  Map<String, dynamic> toJson(LinearGradient gradient) {
    return {
      'colors': gradient.colors.map((c) => c.value).toList(),
      'begin': _alignmentToString(gradient.begin),
      'end': _alignmentToString(gradient.end),
    };
  }

  Alignment _parseAlignment(String? alignmentString) {
    if (alignmentString == null) return Alignment.topLeft;

    switch (alignmentString) {
      case 'Alignment.topLeft':
        return Alignment.topLeft;
      case 'Alignment.topCenter':
        return Alignment.topCenter;
      case 'Alignment.topRight':
        return Alignment.topRight;
      case 'Alignment.centerLeft':
        return Alignment.centerLeft;
      case 'Alignment.center':
        return Alignment.center;
      case 'Alignment.centerRight':
        return Alignment.centerRight;
      case 'Alignment.bottomLeft':
        return Alignment.bottomLeft;
      case 'Alignment.bottomCenter':
        return Alignment.bottomCenter;
      case 'Alignment.bottomRight':
        return Alignment.bottomRight;
      default:
        return Alignment.topLeft;
    }
  }

  String _alignmentToString(AlignmentGeometry alignment) {
    if (alignment == Alignment.topLeft) return 'Alignment.topLeft';
    if (alignment == Alignment.topCenter) return 'Alignment.topCenter';
    if (alignment == Alignment.topRight) return 'Alignment.topRight';
    if (alignment == Alignment.centerLeft) return 'Alignment.centerLeft';
    if (alignment == Alignment.center) return 'Alignment.center';
    if (alignment == Alignment.centerRight) return 'Alignment.centerRight';
    if (alignment == Alignment.bottomCenter) return 'Alignment.bottomCenter';
    if (alignment == Alignment.bottomRight) return 'Alignment.bottomRight';
    return 'Alignment.topLeft';
  }
}

// Helper class for BoxShadow serialization
class BoxShadowConverter
    implements JsonConverter<BoxShadow, Map<String, dynamic>> {
  const BoxShadowConverter();

  @override
  BoxShadow fromJson(Map<String, dynamic> json) {
    return BoxShadow(
      color: Color(json['color'] as int),
      offset: Offset(
        json['offset']['dx'] as double,
        json['offset']['dy'] as double,
      ),
      blurRadius: json['blurRadius'] as double,
      spreadRadius: json['spreadRadius'] as double,
    );
  }

  @override
  Map<String, dynamic> toJson(BoxShadow shadow) {
    return {
      'color': shadow.color.value,
      'offset': {'dx': shadow.offset.dx, 'dy': shadow.offset.dy},
      'blurRadius': shadow.blurRadius,
      'spreadRadius': shadow.spreadRadius,
    };
  }
}

