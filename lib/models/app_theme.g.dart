// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppThemeData _$AppThemeDataFromJson(Map<String, dynamic> json) => AppThemeData(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
  type: $enumDecode(_$ThemeTypeEnumMap, json['type']),
  seasonalType: $enumDecodeNullable(
    _$SeasonalThemeEnumMap,
    json['seasonalType'],
  ),
  isCustom: json['isCustom'] as bool? ?? false,
  isPremium: json['isPremium'] as bool? ?? false,
  colors: AppThemeColors.fromJson(json['colors'] as Map<String, dynamic>),
  gradients: AppThemeGradients.fromJson(
    json['gradients'] as Map<String, dynamic>,
  ),
  shadows: AppThemeShadows.fromJson(json['shadows'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppThemeDataToJson(AppThemeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'type': _$ThemeTypeEnumMap[instance.type]!,
      'seasonalType': _$SeasonalThemeEnumMap[instance.seasonalType],
      'isCustom': instance.isCustom,
      'isPremium': instance.isPremium,
      'colors': instance.colors,
      'gradients': instance.gradients,
      'shadows': instance.shadows,
    };

const _$ThemeTypeEnumMap = {
  ThemeType.light: 'light',
  ThemeType.dark: 'dark',
  ThemeType.seasonal: 'seasonal',
  ThemeType.custom: 'custom',
};

const _$SeasonalThemeEnumMap = {
  SeasonalTheme.spring: 'spring',
  SeasonalTheme.summer: 'summer',
  SeasonalTheme.autumn: 'autumn',
  SeasonalTheme.winter: 'winter',
};

AppThemeColors _$AppThemeColorsFromJson(
  Map<String, dynamic> json,
) => AppThemeColors(
  primary: const ColorConverter().fromJson((json['primary'] as num).toInt()),
  secondary: const ColorConverter().fromJson(
    (json['secondary'] as num).toInt(),
  ),
  background: const ColorConverter().fromJson(
    (json['background'] as num).toInt(),
  ),
  surface: const ColorConverter().fromJson((json['surface'] as num).toInt()),
  onPrimary: const ColorConverter().fromJson(
    (json['onPrimary'] as num).toInt(),
  ),
  onSecondary: const ColorConverter().fromJson(
    (json['onSecondary'] as num).toInt(),
  ),
  onBackground: const ColorConverter().fromJson(
    (json['onBackground'] as num).toInt(),
  ),
  onSurface: const ColorConverter().fromJson(
    (json['onSurface'] as num).toInt(),
  ),
  error: const ColorConverter().fromJson((json['error'] as num).toInt()),
  success: const ColorConverter().fromJson((json['success'] as num).toInt()),
  warning: const ColorConverter().fromJson((json['warning'] as num).toInt()),
  info: const ColorConverter().fromJson((json['info'] as num).toInt()),
  textPrimary: const ColorConverter().fromJson(
    (json['textPrimary'] as num).toInt(),
  ),
  textSecondary: const ColorConverter().fromJson(
    (json['textSecondary'] as num).toInt(),
  ),
  textDisabled: const ColorConverter().fromJson(
    (json['textDisabled'] as num).toInt(),
  ),
  border: const ColorConverter().fromJson((json['border'] as num).toInt()),
  borderFocused: const ColorConverter().fromJson(
    (json['borderFocused'] as num).toInt(),
  ),
  shadow: const ColorConverter().fromJson((json['shadow'] as num).toInt()),
);

Map<String, dynamic> _$AppThemeColorsToJson(AppThemeColors instance) =>
    <String, dynamic>{
      'primary': const ColorConverter().toJson(instance.primary),
      'secondary': const ColorConverter().toJson(instance.secondary),
      'background': const ColorConverter().toJson(instance.background),
      'surface': const ColorConverter().toJson(instance.surface),
      'onPrimary': const ColorConverter().toJson(instance.onPrimary),
      'onSecondary': const ColorConverter().toJson(instance.onSecondary),
      'onBackground': const ColorConverter().toJson(instance.onBackground),
      'onSurface': const ColorConverter().toJson(instance.onSurface),
      'error': const ColorConverter().toJson(instance.error),
      'success': const ColorConverter().toJson(instance.success),
      'warning': const ColorConverter().toJson(instance.warning),
      'info': const ColorConverter().toJson(instance.info),
      'textPrimary': const ColorConverter().toJson(instance.textPrimary),
      'textSecondary': const ColorConverter().toJson(instance.textSecondary),
      'textDisabled': const ColorConverter().toJson(instance.textDisabled),
      'border': const ColorConverter().toJson(instance.border),
      'borderFocused': const ColorConverter().toJson(instance.borderFocused),
      'shadow': const ColorConverter().toJson(instance.shadow),
    };

AppThemeGradients _$AppThemeGradientsFromJson(Map<String, dynamic> json) =>
    AppThemeGradients(
      primary: const LinearGradientConverter().fromJson(
        json['primary'] as Map<String, dynamic>,
      ),
      secondary: const LinearGradientConverter().fromJson(
        json['secondary'] as Map<String, dynamic>,
      ),
      background: const LinearGradientConverter().fromJson(
        json['background'] as Map<String, dynamic>,
      ),
      surface: const LinearGradientConverter().fromJson(
        json['surface'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AppThemeGradientsToJson(AppThemeGradients instance) =>
    <String, dynamic>{
      'primary': const LinearGradientConverter().toJson(instance.primary),
      'secondary': const LinearGradientConverter().toJson(instance.secondary),
      'background': const LinearGradientConverter().toJson(instance.background),
      'surface': const LinearGradientConverter().toJson(instance.surface),
    };

AppThemeShadows _$AppThemeShadowsFromJson(Map<String, dynamic> json) =>
    AppThemeShadows(
      small: (json['small'] as List<dynamic>)
          .map(
            (e) =>
                const BoxShadowConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      medium: (json['medium'] as List<dynamic>)
          .map(
            (e) =>
                const BoxShadowConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      large: (json['large'] as List<dynamic>)
          .map(
            (e) =>
                const BoxShadowConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      card: (json['card'] as List<dynamic>)
          .map(
            (e) =>
                const BoxShadowConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$AppThemeShadowsToJson(AppThemeShadows instance) =>
    <String, dynamic>{
      'small': instance.small.map(const BoxShadowConverter().toJson).toList(),
      'medium': instance.medium.map(const BoxShadowConverter().toJson).toList(),
      'large': instance.large.map(const BoxShadowConverter().toJson).toList(),
      'card': instance.card.map(const BoxShadowConverter().toJson).toList(),
    };
