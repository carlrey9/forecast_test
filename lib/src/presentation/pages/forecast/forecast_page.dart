import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forecast_test/core/constants/decorations.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Position position =
          await ref.read(locationRepository).getLocation(context);

      ref
          .read(forecast3DaysProvider.notifier)
          .getForecast(position.latitude, position.longitude);
    });
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
              return const _LandScapeScreen();
            }
            return _PortraitScreen();
          },
        ),
        floatingActionButton: _FloatingBtn(),
      ),
    ]);
  }
}

class _FloatingBtn extends ConsumerWidget {
  const _FloatingBtn({
    super.key,
  });

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

class _LandScapeScreen extends StatelessWidget {
  const _LandScapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _PortraitScreen extends ConsumerWidget {
  _PortraitScreen({super.key});

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
              return _DataWidget(wheaterNextDaysModel);
            }),
            error: (error, skt) {
              return _ErrorWidget();
            },
            loading: () {
              return LoadingWidget();
            },
          )),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _DataWidget extends StatelessWidget {
  List<WheaterNextDaysModel> wheaterNextDaysModel;
  _DataWidget(
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
            color: Colors.amber,
            child: Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  children: [
                    Text(
                      ' ${DateFormat('EEEE').format(wheaterNextDaysModel[index].time!)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      ' ${wheaterNextDaysModel[index].condition}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          ' ${wheaterNextDaysModel[index].minTemperature}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          ' ${wheaterNextDaysModel[index].maxTemperature}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
                SvgPicture.network(wheaterNextDaysModel[index].icon),
              ]),
            ),
          );
        });
  }
}
