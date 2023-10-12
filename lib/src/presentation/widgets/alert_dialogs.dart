import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future showDialogLocationPermition(BuildContext context) async {
  AlertDialog dialog = AlertDialog(
    title: const Text("Location Permissions"),
    icon: const Icon(
      Icons.location_on_rounded,
      color: Colors.deepPurple,
      size: 30,
    ),
    content: SizedBox(
      height: 180,
      child: Column(
        children: [
          const Text(
            "This app needs your location to show you the information correctly",
            textAlign: TextAlign.center,
          ),
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text("Ok"),
              ),
            );
          })
        ],
      ),
    ),
  );

  await showDialog(context: context, builder: (BuildContext context) => dialog);
}

Future alertDialogInfo(
  BuildContext context,
  String tittle,
  String text,
  String btnText,
  Function function,
) async {
  AlertDialog dialog = AlertDialog(
    title: Text(tittle),
    icon: const Icon(
      Icons.info_outline_rounded,
      color: Colors.deepPurple,
      size: 30,
    ),
    content: SizedBox(
      height: 150,
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
          ),
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () async {
                  await function();
                },
                child: Text(btnText),
              ),
            );
          })
        ],
      ),
    ),
  );

  await showDialog(context: context, builder: (BuildContext context) => dialog);
}
