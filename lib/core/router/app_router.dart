import 'package:forecast_test/src/presentation/pages/forecast/forecast_page.dart';
import 'package:forecast_test/src/presentation/pages/home/home_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        name: "home",
        routes: [
          GoRoute(
            path: 'forecast',
            builder: (context, state) => const ForecastPage(),
            name: "forecast",
          ),
        ]),
  ],
);
