import 'package:mobilemanager/pages/camera-test/camera-test.dart';
import 'package:mobilemanager/pages/home/home-page.dart';
import 'package:mobilemanager/pages/routes.dart';
import 'package:mobilemanager/utils/devices-info.dart';
import 'package:mobilemanager/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  // await mainCameraTest();

  try {
    WidgetsFlutterBinding.ensureInitialized();
    await DevicesInfo.init();
  } on Exception catch (e) {
    Logger.log(e);
  }
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Attendance Machine',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: routes,
    );
  }
}
