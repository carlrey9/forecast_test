import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const gradientdecoration = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: [
    Color.fromARGB(255, 16, 1, 48),
    Color.fromARGB(255, 18, 1, 46),
    Color.fromARGB(255, 42, 2, 134),
    Color.fromARGB(255, 3, 1, 112),
    Color.fromARGB(255, 40, 0, 151),
    Color.fromARGB(255, 2, 32, 90),
    Color.fromARGB(255, 4, 69, 143),
    Color.fromARGB(255, 2, 135, 243),
  ],
));

void noShadowStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}
