import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_test/src/data/remote/repositories/forecast_repository.dart';

import 'package:forecast_test/src/domain/models/wheater_next_days_model.dart';

class WheaterNextDaysNotifier
    extends StateNotifier<AsyncValue<List<WheaterNextDaysModel>>> {
  WheaterNextDaysNotifier(this.forecastRepository)
      : super(const AsyncLoading());

  ForecastRepository forecastRepository;
  AsyncValue<List<WheaterNextDaysModel>>? previousState;

  Future<void> getForecast(double lat, double lon) async {
    previousState = state;
    state = const AsyncLoading();

    try {
      List<WheaterNextDaysModel> wheaterNextDaysModel =
          await forecastRepository.getForescast3NextDays(lat, lon);
      state = AsyncValue.data(wheaterNextDaysModel);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
