// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wheater_next_days_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WheaterNextDaysModel _$WheaterNextDaysModelFromJson(Map<String, dynamic> json) {
  return _WheaterNextDaysModel.fromJson(json);
}

/// @nodoc
mixin _$WheaterNextDaysModel {
  DateTime? get time => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  int get maxTemperature => throw _privateConstructorUsedError;
  int get minTemperature => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WheaterNextDaysModelCopyWith<WheaterNextDaysModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WheaterNextDaysModelCopyWith<$Res> {
  factory $WheaterNextDaysModelCopyWith(WheaterNextDaysModel value,
          $Res Function(WheaterNextDaysModel) then) =
      _$WheaterNextDaysModelCopyWithImpl<$Res, WheaterNextDaysModel>;
  @useResult
  $Res call(
      {DateTime? time,
      String condition,
      String icon,
      int maxTemperature,
      int minTemperature});
}

/// @nodoc
class _$WheaterNextDaysModelCopyWithImpl<$Res,
        $Val extends WheaterNextDaysModel>
    implements $WheaterNextDaysModelCopyWith<$Res> {
  _$WheaterNextDaysModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = freezed,
    Object? condition = null,
    Object? icon = null,
    Object? maxTemperature = null,
    Object? minTemperature = null,
  }) {
    return _then(_value.copyWith(
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      maxTemperature: null == maxTemperature
          ? _value.maxTemperature
          : maxTemperature // ignore: cast_nullable_to_non_nullable
              as int,
      minTemperature: null == minTemperature
          ? _value.minTemperature
          : minTemperature // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WheaterNextDaysModelImplCopyWith<$Res>
    implements $WheaterNextDaysModelCopyWith<$Res> {
  factory _$$WheaterNextDaysModelImplCopyWith(_$WheaterNextDaysModelImpl value,
          $Res Function(_$WheaterNextDaysModelImpl) then) =
      __$$WheaterNextDaysModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? time,
      String condition,
      String icon,
      int maxTemperature,
      int minTemperature});
}

/// @nodoc
class __$$WheaterNextDaysModelImplCopyWithImpl<$Res>
    extends _$WheaterNextDaysModelCopyWithImpl<$Res, _$WheaterNextDaysModelImpl>
    implements _$$WheaterNextDaysModelImplCopyWith<$Res> {
  __$$WheaterNextDaysModelImplCopyWithImpl(_$WheaterNextDaysModelImpl _value,
      $Res Function(_$WheaterNextDaysModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = freezed,
    Object? condition = null,
    Object? icon = null,
    Object? maxTemperature = null,
    Object? minTemperature = null,
  }) {
    return _then(_$WheaterNextDaysModelImpl(
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      maxTemperature: null == maxTemperature
          ? _value.maxTemperature
          : maxTemperature // ignore: cast_nullable_to_non_nullable
              as int,
      minTemperature: null == minTemperature
          ? _value.minTemperature
          : minTemperature // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WheaterNextDaysModelImpl implements _WheaterNextDaysModel {
  _$WheaterNextDaysModelImpl(
      {this.time,
      required this.condition,
      required this.icon,
      required this.maxTemperature,
      required this.minTemperature});

  factory _$WheaterNextDaysModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WheaterNextDaysModelImplFromJson(json);

  @override
  final DateTime? time;
  @override
  final String condition;
  @override
  final String icon;
  @override
  final int maxTemperature;
  @override
  final int minTemperature;

  @override
  String toString() {
    return 'WheaterNextDaysModel(time: $time, condition: $condition, icon: $icon, maxTemperature: $maxTemperature, minTemperature: $minTemperature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WheaterNextDaysModelImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.maxTemperature, maxTemperature) ||
                other.maxTemperature == maxTemperature) &&
            (identical(other.minTemperature, minTemperature) ||
                other.minTemperature == minTemperature));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, time, condition, icon, maxTemperature, minTemperature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WheaterNextDaysModelImplCopyWith<_$WheaterNextDaysModelImpl>
      get copyWith =>
          __$$WheaterNextDaysModelImplCopyWithImpl<_$WheaterNextDaysModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WheaterNextDaysModelImplToJson(
      this,
    );
  }
}

abstract class _WheaterNextDaysModel implements WheaterNextDaysModel {
  factory _WheaterNextDaysModel(
      {final DateTime? time,
      required final String condition,
      required final String icon,
      required final int maxTemperature,
      required final int minTemperature}) = _$WheaterNextDaysModelImpl;

  factory _WheaterNextDaysModel.fromJson(Map<String, dynamic> json) =
      _$WheaterNextDaysModelImpl.fromJson;

  @override
  DateTime? get time;
  @override
  String get condition;
  @override
  String get icon;
  @override
  int get maxTemperature;
  @override
  int get minTemperature;
  @override
  @JsonKey(ignore: true)
  _$$WheaterNextDaysModelImplCopyWith<_$WheaterNextDaysModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
