import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forecast_test/core/constants/decorations.dart';
import 'package:forecast_test/src/data/local/location/gps_location.dart';
import 'package:forecast_test/src/domain/models/wheater_model.dart';
import 'package:forecast_test/src/domain/providers/forecast_providers.dart';
import 'package:forecast_test/src/presentation/widgets/blur_widget.dart';
import 'package:forecast_test/src/presentation/widgets/loading_widget.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return const Scaffold(
      body: _Body(),
      floatingActionButton: FloatingBtn(),
    );
  }
}

class FloatingBtn extends ConsumerWidget {
  const FloatingBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () async {
        Position position =
            await ref.read(locationRepository).getLocation(context);
        print("lat:  ${position.latitude}");
        print("lon:  ${position.longitude}");
        ref
            .read(forecastProvider.notifier)
            .getForecast(position.latitude, position.longitude);
      },
      child: const Icon(Icons.refresh),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecast = ref.watch(forecastProvider);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: gradientdecoration,
      child: forecast.when(
        data: ((WheaterModel wheaterModel) {
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const BlurWidget(),
            _TextToday(wheaterModel),
            _Icon(wheaterModel),
          ]);
        }),
        error: (error, skt) {
          return Text("$error");
        },
        loading: () => const Center(child: LoadingWidget()),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  WheaterModel wheaterModel;
  _Icon(
    this.wheaterModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      wheaterModel.urlIcon,
      height: 300,
      placeholderBuilder: (context) {
        return Center(child: LoadingWidget());
      },
    );
  }
}

class _TextToday extends StatelessWidget {
  WheaterModel wheaterModel;
  _TextToday(
    this.wheaterModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      wheaterModel.condition,
      style: const TextStyle(color: Colors.white),
    );
  }
}
