// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wheater_next_days_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WheaterNextDaysModelImpl _$$WheaterNextDaysModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WheaterNextDaysModelImpl(
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      condition: json['condition'] as String,
      icon: json['icon'] as String,
      maxTemperature: json['maxTemperature'] as int,
      minTemperature: json['minTemperature'] as int,
    );

Map<String, dynamic> _$$WheaterNextDaysModelImplToJson(
        _$WheaterNextDaysModelImpl instance) =>
    <String, dynamic>{
      'time': instance.time?.toIso8601String(),
      'condition': instance.condition,
      'icon': instance.icon,
      'maxTemperature': instance.maxTemperature,
      'minTemperature': instance.minTemperature,
    };
