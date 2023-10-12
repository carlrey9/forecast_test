import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_test/src/data/remote/repositories/forecast_repository.dart';

final forecastRepository =
    Provider<ForecastRepository>((ref) => ForecastRepositoryImpl());
