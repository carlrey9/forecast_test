import 'package:flutter/material.dart';
import 'package:forecast_test/core/constants/decorations.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    noShadowStatusBar();
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.landscape) {
            return const _LandScapeScreen();
          }
          return const _PortraitScreen();
        },
      ),
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

class _PortraitScreen extends StatelessWidget {
  const _PortraitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
