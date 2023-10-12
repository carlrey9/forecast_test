import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_test/src/data/remote/providers/forecastProvider.dart';
import 'package:forecast_test/src/domain/models/wheater_model.dart';
import 'package:forecast_test/src/domain/models/wheater_next_days_model.dart';
import 'package:forecast_test/src/domain/providers/forecast_next_days_state_notifier.dart';
import 'package:forecast_test/src/domain/providers/forecast_state_notifier.dart';

final forecastProvider =
    StateNotifierProvider<WheaterNotifier, AsyncValue<WheaterModel>>((ref) {
  return WheaterNotifier(ref.watch(forecastRepository));
});

final forecast3DaysProvider = StateNotifierProvider<WheaterNextDaysNotifier,
    AsyncValue<List<WheaterNextDaysModel>>>((ref) {
  return WheaterNextDaysNotifier(ref.watch(forecastRepository));
});
