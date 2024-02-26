import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'weather_model.freezed.dart';
part 'weather_model.g.dart'; // This is the generated file for JSON serialization

@freezed
class Weather with _$Weather {
  const factory Weather({
    required double temperature,
    required String condition,
    required String location,
    required String country,
  }) = _WeatherData;

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
}
