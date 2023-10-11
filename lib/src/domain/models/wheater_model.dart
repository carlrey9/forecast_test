import 'package:freezed_annotation/freezed_annotation.dart';

part 'wheater_model.freezed.dart';
part 'wheater_model.g.dart';

@freezed
class WheaterModel with _$WheaterModel {
  const factory WheaterModel({
    required double obs_time,
    required double uptime,
    required double temp,
    required double feels_like,
    required double temp_water,
    required String icon,
    required String condition,
    required double cloudness,
    required double prec_type,
    required double prec_prob,
    required double prec_strength,
    required bool is_thunder,
    required double wind_speed,
    required String wind_dir,
    required double pressure_mm,
    required double pressure_pa,
    required double humidity,
    required String daytime,
    required bool polar,
    required String season,
    required String source,
    required double soil_moisture,
    required double soil_temp,
    required double uv_index,
    required double wind_gust,
  }) = _WheaterModel;

  factory WheaterModel.fromJson(Map<String, dynamic> json) =>
      _$WheaterModelFromJson(json);
}
