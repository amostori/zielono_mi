import 'package:go_router/go_router.dart';
import 'package:zielone_japko/src/features/home/presentation/home.dart';
import 'package:zielone_japko/src/utils/error_page.dart';

enum AppRoute {
  home,
}

final routeByName = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const ErrorPage(),
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const Home(),
    ),
  ],
);
