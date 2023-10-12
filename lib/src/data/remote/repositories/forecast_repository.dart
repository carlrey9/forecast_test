import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:forecast_test/core/api/api_key.dart';
import 'package:forecast_test/src/domain/models/wheater_model.dart';
import 'package:forecast_test/src/domain/models/wheater_next_days_model.dart';

abstract class ForecastRepository {
  Future<WheaterModel> getWheather(double lat, double lon);
  Future<String> getUrlIcon(double lat, double lon);
  Future<List<WheaterNextDaysModel>> getForescast3NextDays(
      double lat, double lon);
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

  @override
  Future<List<WheaterNextDaysModel>> getForescast3NextDays(
      double lat, double lon) async {
    try {
      final response = await dio.post(
        endPointGetWheaterGraphQl,
        options: Options(
          headers: {"X-Meteum-API-Key": forecastKey},
        ),
        data: {
          "query":
              "{\n  weatherByPoint(request: { lat: 52.37175, lon: 4.89358 }) {\n    forecast {\n      days(limit: 5) {\n        time\n          parts{\n              day{\n                condition     \n                icon(format: SVG, theme: CIRCLE)            \n                maxTemperature\n                minTemperature\n              }\n          }\n      }\n    }\n  }\n}"
        },
      );

      // log("data: ${response.data['data']['weatherByPoint']['forecast']['days'][0]['parts']['day']}");
      List<WheaterNextDaysModel> wheaterMoreDays = [];
      for (var dayData in response.data['data']['weatherByPoint']['forecast']
          ['days']) {
        //set basic info
        WheaterNextDaysModel wheaterNextDaysModel =
            WheaterNextDaysModel.fromJson(dayData['parts']['day']);
        //set time info
        wheaterNextDaysModel = wheaterNextDaysModel.copyWith(
            time: DateTime.parse(dayData['time']));

        //add info to list
        wheaterMoreDays.add(wheaterNextDaysModel);
      }
      return wheaterMoreDays;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionError) {
        return Future.error(
            "Connection Error \n Please check your internet connection and try again");
      }
      return Future.error(error);
    }
  }
}
