// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wheater_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WheaterModelImpl _$$WheaterModelImplFromJson(Map<String, dynamic> json) =>
    _$WheaterModelImpl(
      obs_time: (json['obs_time'] as num).toDouble(),
      uptime: (json['uptime'] as num).toDouble(),
      temp: (json['temp'] as num).toDouble(),
      feels_like: (json['feels_like'] as num).toDouble(),
      temp_water: (json['temp_water'] as num?)?.toDouble() ?? 0.0,
      icon: json['icon'] as String,
      condition: json['condition'] as String,
      cloudness: (json['cloudness'] as num).toDouble(),
      prec_type: (json['prec_type'] as num).toDouble(),
      prec_prob: (json['prec_prob'] as num).toDouble(),
      prec_strength: (json['prec_strength'] as num).toDouble(),
      is_thunder: json['is_thunder'] as bool,
      wind_speed: (json['wind_speed'] as num).toDouble(),
      wind_dir: json['wind_dir'] as String,
      pressure_mm: (json['pressure_mm'] as num).toDouble(),
      pressure_pa: (json['pressure_pa'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      daytime: json['daytime'] as String,
      polar: json['polar'] as bool,
      season: json['season'] as String,
      source: json['source'] as String,
      soil_moisture: (json['soil_moisture'] as num).toDouble(),
      soil_temp: (json['soil_temp'] as num).toDouble(),
      uv_index: (json['uv_index'] as num).toDouble(),
      wind_gust: (json['wind_gust'] as num).toDouble(),
      urlIcon: json['urlIcon'] as String? ?? "",
    );

Map<String, dynamic> _$$WheaterModelImplToJson(_$WheaterModelImpl instance) =>
    <String, dynamic>{
      'obs_time': instance.obs_time,
      'uptime': instance.uptime,
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'temp_water': instance.temp_water,
      'icon': instance.icon,
      'condition': instance.condition,
      'cloudness': instance.cloudness,
      'prec_type': instance.prec_type,
      'prec_prob': instance.prec_prob,
      'prec_strength': instance.prec_strength,
      'is_thunder': instance.is_thunder,
      'wind_speed': instance.wind_speed,
      'wind_dir': instance.wind_dir,
      'pressure_mm': instance.pressure_mm,
      'pressure_pa': instance.pressure_pa,
      'humidity': instance.humidity,
      'daytime': instance.daytime,
      'polar': instance.polar,
      'season': instance.season,
      'source': instance.source,
      'soil_moisture': instance.soil_moisture,
      'soil_temp': instance.soil_temp,
      'uv_index': instance.uv_index,
      'wind_gust': instance.wind_gust,
      'urlIcon': instance.urlIcon,
    };
