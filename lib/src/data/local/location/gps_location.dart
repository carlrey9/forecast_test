import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_test/src/presentation/widgets/alert_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

abstract class GPSLocation {
  Future<Position> getLocation(BuildContext context);
}

class GPSLocationLocator extends GPSLocation {
  @override
  Future<Position> getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // ignore: use_build_context_synchronously
      await showDialogLocationPermition(context);
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      await alertDialogInfo(
        context,
        "Location permission",
        "Location permissions have been denied",
        "Ok",
        () async {
          context.pop();
          permission = await Geolocator.requestPermission();
        },
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

final locationRepository = Provider<GPSLocation>((ref) => GPSLocationLocator());
