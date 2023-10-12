import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_test/src/data/remote/repositories/forecast_repository.dart';
import 'package:forecast_test/src/domain/models/wheater_model.dart';

class WheaterNotifier extends StateNotifier<AsyncValue<WheaterModel>> {
  WheaterNotifier(this.forecastRepository)
      : super(AsyncError("No data", StackTrace.empty));

  ForecastRepository forecastRepository;
  AsyncValue<WheaterModel>? previousState;

  Future<void> getForecast(double lat, double lon) async {
    previousState = state;
    state = const AsyncLoading();

    try {
      WheaterModel wheaterModel =
          await forecastRepository.getWheather(lat, lon);

      state = AsyncValue.data(wheaterModel);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
      return Future.error(error);
    }
  }
}
