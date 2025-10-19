// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Achievement _$AchievementFromJson(Map<String, dynamic> json) => Achievement(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
  type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
  rarity: $enumDecode(_$AchievementRarityEnumMap, json['rarity']),
  targetValue: (json['targetValue'] as num).toInt(),
  treasureType: json['treasureType'] as String?,
  isUnlocked: json['isUnlocked'] as bool? ?? false,
  unlockedAt: json['unlockedAt'] == null
      ? null
      : DateTime.parse(json['unlockedAt'] as String),
  currentProgress: (json['currentProgress'] as num?)?.toInt() ?? 0,
  xpReward: (json['xpReward'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AchievementToJson(Achievement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'icon': instance.icon,
      'type': _$AchievementTypeEnumMap[instance.type]!,
      'rarity': _$AchievementRarityEnumMap[instance.rarity]!,
      'targetValue': instance.targetValue,
      'treasureType': instance.treasureType,
      'isUnlocked': instance.isUnlocked,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
      'currentProgress': instance.currentProgress,
      'xpReward': instance.xpReward,
    };

const _$AchievementTypeEnumMap = {
  AchievementType.streak: 'streak',
  AchievementType.count: 'count',
  AchievementType.treasureType: 'treasure_type',
  AchievementType.level: 'level',
  AchievementType.special: 'special',
};

const _$AchievementRarityEnumMap = {
  AchievementRarity.common: 'common',
  AchievementRarity.rare: 'rare',
  AchievementRarity.epic: 'epic',
  AchievementRarity.legendary: 'legendary',
};

UserLevel _$UserLevelFromJson(Map<String, dynamic> json) => UserLevel(
  level: (json['level'] as num).toInt(),
  currentXp: (json['currentXp'] as num).toInt(),
  xpToNextLevel: (json['xpToNextLevel'] as num).toInt(),
  totalXp: (json['totalXp'] as num).toInt(),
);

Map<String, dynamic> _$UserLevelToJson(UserLevel instance) => <String, dynamic>{
  'level': instance.level,
  'currentXp': instance.currentXp,
  'xpToNextLevel': instance.xpToNextLevel,
  'totalXp': instance.totalXp,
};
