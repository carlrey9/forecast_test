import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:forecast_test/src/domain/models/wheater_model.dart';

abstract class ForecastRepository {
  Future<WheaterModel> getWheather(double lat, double lon);
}

final key = "cc7f182e-4997-4f59-8e87-ea48cabe2515";
//final endPointGetWheater = 'https://api.meteum.ai/v1/fact?lat=52.37125&lon=4.89388';
final endPointGetWheater = 'https://api.meteum.ai/v1/fact';

class ForecastRepositoryImpl extends ForecastRepository {
  final dio = Dio();
  @override
  Future<WheaterModel> getWheather(double lat, double lon) async {
    try {
      final response = await dio.get(endPointGetWheater,
          queryParameters: {'lat': lat, 'lon': lon},
          options: Options(headers: {"X-Meteum-API-Key": key}));

      WheaterModel wheaterModel = WheaterModel.fromJson(response.data);
      log("data: " + wheaterModel.toString());
      return wheaterModel;
    } catch (error) {
      return Future.error(error);
    }
  }
}
