import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_test/src/presentation/widgets/alert_dialog_location.dart';
import 'package:geolocator/geolocator.dart';

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
      await showDialogLocationPermition(context);
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

final locationRepository = Provider<GPSLocation>((ref) => GPSLocationLocator());
