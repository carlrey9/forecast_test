import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forecast_test/core/constants/decorations.dart';
import 'package:forecast_test/src/data/local/location/gps_location.dart';
import 'package:forecast_test/src/domain/models/wheater_model.dart';
import 'package:forecast_test/src/domain/providers/forecast_providers.dart';
import 'package:forecast_test/src/presentation/widgets/blur_widget.dart';
import 'package:forecast_test/src/presentation/widgets/loading_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    noShadowStatusBar();
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.landscape) {
            return _LandScapeScreen();
          }
          return _PortraitScreen();
        },
      ),
      floatingActionButton: const FloatingBtn(),
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

        ref
            .read(forecastProvider.notifier)
            .getForecast(position.latitude, position.longitude);
      },
      child: const Icon(Icons.refresh),
    );
  }
}

class _LandScapeScreen extends ConsumerWidget {
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
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TextWheater(wheaterModel),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Icon(wheaterModel),
                      _TextDegrees(wheaterModel),
                      _NextDaysBtn(),
                    ],
                  ),
                ],
              ),
            )
          ]);
        }),
        error: (error, skt) {
          return Center(child: Text("$error"));
        },
        loading: () => const Center(child: LoadingWidget()),
      ),
    );
  }
}

class _PortraitScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecast = ref.watch(forecastProvider);
    return Container(
      decoration: gradientdecoration,
      child: forecast.when(
        data: ((WheaterModel wheaterModel) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const BlurWidget(),
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    _TextWheater(wheaterModel),
                    _Icon(wheaterModel),
                    _TextDegrees(wheaterModel),
                    _NextDaysBtn(),
                  ],
                ),
              )
            ],
          );
        }),
        error: (error, skt) {
          if (error == "No data") {
            return _NoDataWidget();
          }
          return Center(
              child: Container(
            height: 300,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 60,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "$error",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ]),
          ));
        },
        loading: () => const Center(child: LoadingWidget()),
      ),
    );
  }
}

class _NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BlurWidget(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12)),
          child: const Column(children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.emoji_emotions_outlined,
                size: 60,
                color: Colors.white70,
              ),
            ),
            Text(
              "Welcome to your forecast app\n please press the button to update the information",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ]),
        )
      ],
    );
  }
}

class _NextDaysBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: MaterialButton(
        onPressed: () {
          context.goNamed("forecast");
        },
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "More",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
              ),
              Icon(
                Icons.keyboard_double_arrow_right_rounded,
                color: Colors.white,
                size: 30,
              ),
            ]),
      ),
    );
  }
}

class _TextDegrees extends StatelessWidget {
  final WheaterModel wheaterModel;
  const _TextDegrees(this.wheaterModel);

  @override
  Widget build(BuildContext context) {
    return Text("${wheaterModel.temp}°",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ));
  }
}

class _Icon extends StatelessWidget {
  final WheaterModel wheaterModel;
  const _Icon(
    this.wheaterModel,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: SizedBox(
        height: 200,
        child: SvgPicture.network(
          wheaterModel.urlIcon,
          height: 200,
          placeholderBuilder: (context) {
            return const Center(child: LoadingWidget());
          },
        ),
      ),
    );
  }
}

class _TextWheater extends StatelessWidget {
  final WheaterModel wheaterModel;
  const _TextWheater(this.wheaterModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        wheaterModel.condition,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }
}
