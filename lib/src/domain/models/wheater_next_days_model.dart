import 'package:freezed_annotation/freezed_annotation.dart';

part 'wheater_next_days_model.freezed.dart';
part 'wheater_next_days_model.g.dart';

@freezed
class WheaterNextDaysModel with _$WheaterNextDaysModel {
  factory WheaterNextDaysModel({
    DateTime? time,
    required String condition,
    required String icon,
    required int maxTemperature,
    required int minTemperature,
  }) = _WheaterNextDaysModel;

  factory WheaterNextDaysModel.fromJson(Map<String, dynamic> json) =>
      _$WheaterNextDaysModelFromJson(json);
}
