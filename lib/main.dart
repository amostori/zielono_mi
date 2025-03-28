import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zielone_japko/src/features/home/hive_helper/tea_time_box.dart';
import 'package:zielone_japko/src/utils/routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final teaTimeBox = TeaTimeBox();
  await teaTimeBox.initTeaTimeBox();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const ProviderScope(overrides: [],child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routeByName,
      title: 'Zielone japko',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
