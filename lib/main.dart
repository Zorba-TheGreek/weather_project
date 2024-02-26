import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_project/screens/home_screen.dart';
import 'package:weather_project/screens/settings_screen.dart';
import 'models/weather_view_model.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherViewModel(),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/settings': (context) => SettingsScreen(),
        },
      ),
    );
  }
}
