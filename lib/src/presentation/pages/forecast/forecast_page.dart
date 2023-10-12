import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forecast_test/core/constants/decorations.dart';
import 'package:forecast_test/core/functions/text_functions.dart';
import 'package:forecast_test/src/data/local/location/gps_location.dart';
import 'package:forecast_test/src/domain/models/wheater_next_days_model.dart';
import 'package:forecast_test/src/domain/providers/forecast_providers.dart';
import 'package:forecast_test/src/presentation/widgets/blur_widget.dart';
import 'package:forecast_test/src/presentation/widgets/loading_widget.dart';
import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';

class ForecastPage extends ConsumerStatefulWidget {
  const ForecastPage({super.key});

  @override
  ForecastPageState createState() => ForecastPageState();
}

class ForecastPageState extends ConsumerState<ForecastPage> {
  @override
  void initState() {
    super.initState();
    _getWheater(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    noShadowStatusBar();
    return Stack(children: [
      const BlurWidget(),
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if (orientation == Orientation.landscape) {
              return _LandScapeScreen();
            }
            return _PortraitScreen();
          },
        ),
        floatingActionButton: _FloatingBtn(),
      ),
    ]);
  }

  Future<void> _getWheater(BuildContext context, WidgetRef ref) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Position position =
          await ref.read(locationRepository).getLocation(context);

      ref
          .read(forecast3DaysProvider.notifier)
          .getForecast(position.latitude, position.longitude);
    });
  }
}

class _FloatingBtn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () async {
        Position position =
            await ref.read(locationRepository).getLocation(context);

        ref
            .read(forecast3DaysProvider.notifier)
            .getForecast(position.latitude, position.longitude);
      },
      child: const Icon(Icons.refresh),
    );
  }
}

class _LandScapeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forescast3Days = ref.watch(forecast3DaysProvider);
    return Container(
      decoration: gradientdecoration,
      child: Stack(
        children: [
          // const BlurWidget(),
          Center(
              child: forescast3Days.when(
            data: ((List<WheaterNextDaysModel> wheaterNextDaysModel) {
              return _DataWidgetLand(wheaterNextDaysModel);
            }),
            error: (error, skt) {
              return _ErrorWidget(error);
            },
            loading: () {
              return const LoadingWidget();
            },
          )),
        ],
      ),
    );
  }
}

class _PortraitScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forescast3Days = ref.watch(forecast3DaysProvider);
    return Container(
      decoration: gradientdecoration,
      child: Stack(
        children: [
          // const BlurWidget(),
          Center(
              child: forescast3Days.when(
            data: ((List<WheaterNextDaysModel> wheaterNextDaysModel) {
              return _DataWidgetPort(wheaterNextDaysModel);
            }),
            error: (error, skt) {
              return _ErrorWidget(error);
            },
            loading: () {
              return const LoadingWidget();
            },
          )),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final Object error;
  const _ErrorWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
  }
}

class _DataWidgetPort extends StatelessWidget {
  final List<WheaterNextDaysModel> wheaterNextDaysModel;
  const _DataWidgetPort(
    this.wheaterNextDaysModel,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: wheaterNextDaysModel.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Column(
                children: [
                  _NameDayWidget(
                      wheaterOneDayModel: wheaterNextDaysModel[index]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              _ConditionWidget(
                                  wheaterOneDayModel:
                                      wheaterNextDaysModel[index]),
                              _TemperatureWidget(
                                  wheaterOneDayModel:
                                      wheaterNextDaysModel[index])
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.network(
                              wheaterNextDaysModel[index].icon,
                              height: 50,
                              placeholderBuilder: (context) {
                                return const Center(child: LoadingWidget());
                              },
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          );
        });
  }
}

class _DataWidgetLand extends StatelessWidget {
  final List<WheaterNextDaysModel> wheaterNextDaysModel;
  const _DataWidgetLand(
    this.wheaterNextDaysModel,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: wheaterNextDaysModel.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NameDayWidget(
                      wheaterOneDayModel: wheaterNextDaysModel[index]),
                  _ConditionWidget(
                      wheaterOneDayModel: wheaterNextDaysModel[index]),
                  _TemperatureWidget(
                      wheaterOneDayModel: wheaterNextDaysModel[index]),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.network(
                      wheaterNextDaysModel[index].icon,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class _TemperatureWidget extends StatelessWidget {
  const _TemperatureWidget({
    required this.wheaterOneDayModel,
  });

  final WheaterNextDaysModel wheaterOneDayModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "Temp:",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        const SizedBox(width: 30),
        const Text(
          "Min...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        Text(
          ' ${wheaterOneDayModel.minTemperature}°',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 30),
        const Text(
          "Max...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        Text(
          ' ${wheaterOneDayModel.maxTemperature}°',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class _ConditionWidget extends StatelessWidget {
  const _ConditionWidget({
    required this.wheaterOneDayModel,
  });

  final WheaterNextDaysModel wheaterOneDayModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      ' ${TextFunctions().toShow(wheaterOneDayModel.condition)}',
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _NameDayWidget extends StatelessWidget {
  const _NameDayWidget({
    required this.wheaterOneDayModel,
  });

  final WheaterNextDaysModel wheaterOneDayModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      ' ${(DateFormat('EEEE').format(wheaterOneDayModel.time!))}',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
