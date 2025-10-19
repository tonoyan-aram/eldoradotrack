// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treasure_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreasureEntry _$TreasureEntryFromJson(Map<String, dynamic> json) =>
    TreasureEntry(
      id: json['id'] as String,
      text: json['text'] as String,
      types: (json['types'] as List<dynamic>)
          .map((e) => $enumDecode(_$TreasureTypeEnumMap, e))
          .toList(),
      value: (json['value'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TreasureEntryToJson(TreasureEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'types': instance.types.map((e) => _$TreasureTypeEnumMap[e]!).toList(),
      'value': instance.value,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$TreasureTypeEnumMap = {
  TreasureType.gold: 'gold',
  TreasureType.jewelry: 'jewelry',
  TreasureType.artifacts: 'artifacts',
  TreasureType.coins: 'coins',
  TreasureType.gems: 'gems',
  TreasureType.other: 'other',
};
