import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../repository/weather_repository.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();
  List<Weather> _weatherList = [];
  bool _loading = false;
  String _error = '';

  List<Weather> get weatherList => _weatherList;
  bool get loading => _loading;
  String get error => _error;

  Future<void> fetchWeatherByLocation() async {
    _loading = true;
    notifyListeners();

    try {
      final position = await Geolocator.getCurrentPosition();
      final response = await _repository.fetchWeatherByLocation(position.latitude, position.longitude);
      final json = response as Map<String, dynamic>;
      if (json != null && json is Map<String, dynamic>) {
        _weatherList = [
          Weather(
            temperature: json['main']['temp'],
            condition: json['weather'][0]['description'],
            location: json['name'],
            country: json['sys']['country'],
          )
        ];
        _error = '';
      } else {
        _error = 'Invalid response format';
      }
    } catch (e) {
      _error = 'Failed to fetch weather data';
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> fetchWeatherByCity(String city, String country) async {
    _loading = true;
    notifyListeners();

    try {
      final response = await _repository.fetchWeatherByCity(city, country);
      final json = response as Map<String, dynamic>;;
      if (json != null && json is Map<String, dynamic>) {
        _weatherList = [
          Weather(
            temperature: json['main']['temp'],
            condition: json['weather'][0]['description'],
            location: json['name'],
            country: json['sys']['country'],
          )
        ];
        _error = '';
      } else {
        _error = 'Invalid response format';
      }
    } catch (e) {
      _error = 'Failed to fetch weather data';
    }

    _loading = false;
    notifyListeners();
  }
}
