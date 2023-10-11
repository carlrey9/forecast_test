import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_test/src/domain/models/wheater_model.dart';
import 'package:forecast_test/src/domain/providers/forecast_providers.dart';
import 'package:forecast_test/src/presentation/widgets/loading_widget.dart';

//cc7f182e-4997-4f59-8e87-ea48cabe2515
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      onPressed: () {
        ref.read(forecastProvider.notifier).getForecast(52.3712, 4.89388);
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
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Home"),
      forecast.when(
        data: ((WheaterModel wheaterModel) {
          return Text(wheaterModel.condition);
        }),
        error: (error, skt) {
          return Text("Error: " + error.toString());
        },
        loading: () => Center(child: const LoadingWidget()),
      )
    ]);
  }
}
