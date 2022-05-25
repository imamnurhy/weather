import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'app/page/weather_seccond_page.dart';
import 'app/page/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Geolocator.checkPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherSeccondPage(),
    );
  }
}
