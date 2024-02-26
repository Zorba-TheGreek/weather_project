import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherRepository {
  static const String apiKey = '8b45a5bdfcd26afb32115a773d0a9439';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeatherByLocation(double lat, double lon) async {
    try {
      final url = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherByCity(String city, String country) async {
    try {
      final url = '$baseUrl?q=$city,$country&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}
