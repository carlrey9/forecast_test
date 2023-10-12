import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future showDialogLocationPermition(BuildContext context) async {
  AlertDialog dialog = AlertDialog(
    title: const Text("Location Permissions"),
    icon: const Icon(Icons.location_on_rounded),
    content: Column(
      children: [
        const Text(
            "This app needs your location to show you the information correctly"),
        Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text("Ok"),
          );
        })
      ],
    ),
  );

  await showDialog(context: context, builder: (BuildContext context) => dialog);
}
