// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherDataImpl _$$WeatherDataImplFromJson(Map<String, dynamic> json) =>
    _$WeatherDataImpl(
      temperature: (json['temperature'] as num).toDouble(),
      condition: json['condition'] as String,
      location: json['location'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$$WeatherDataImplToJson(_$WeatherDataImpl instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'condition': instance.condition,
      'location': instance.location,
      'country': instance.country,
    };
