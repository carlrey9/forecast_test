import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:forecast_test/core/api/api_key.dart';
import 'package:forecast_test/src/domain/models/wheater_model.dart';

abstract class ForecastRepository {
  Future<WheaterModel> getWheather(double lat, double lon);
  Future<String> getUrlIcon(double lat, double lon);
}

const endPointGetWheater = 'https://api.meteum.ai/v1/fact';
const endPointGetWheaterGraphQl = 'https://api.meteum.ai/graphql/query';

class ForecastRepositoryImpl extends ForecastRepository {
  final dio = Dio();
  @override
  Future<WheaterModel> getWheather(double lat, double lon) async {
    try {
      final response = await dio.get(
        endPointGetWheater,
        queryParameters: {
          'lat': lat,
          'lon': lon,
        },
        options: Options(
          headers: {"X-Meteum-API-Key": forecastKey},
        ),
      );

      WheaterModel wheaterModel = WheaterModel.fromJson(response.data);
      wheaterModel = wheaterModel.copyWith(urlIcon: await getUrlIcon(lat, lon));
      log("data: $wheaterModel");
      return wheaterModel;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionError) {
        return Future.error(
            "Connection Error \n Please check your internet connection and try again");
      }
      return Future.error(error);
    }
  }

  @override
  Future<String> getUrlIcon(double lat, double lon) async {
    try {
      final response = await dio.post(endPointGetWheaterGraphQl,
          options: Options(
            headers: {"X-Meteum-API-Key": forecastKey},
          ),
          data: {
            "query":
                "{\n  weatherByPoint(request: {lat: $lat, lon: $lon}) {\n    now {\n      icon(format: SVG, theme: CIRCLE)\n}\n    \n}\n}"
          });

      log("data: ${response.data['data']['weatherByPoint']['now']['icon']}");
      return response.data['data']['weatherByPoint']['now']['icon'];
    } catch (error) {
      return Future.error(error);
    }
  }
}
