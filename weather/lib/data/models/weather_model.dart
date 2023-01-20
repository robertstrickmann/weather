import 'package:equatable/equatable.dart';
import 'package:weather/domain/entities/weather.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    required this.timestamp,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.description,
    required this.iconId,
  });

  final int timestamp;
  final double temperature;
  final int pressure;
  final int humidity;
  final String description;
  final String iconId;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    timestamp: json['current']['dt'],
    temperature: json['current']['temp'],
    pressure: json['current']['pressure'],
    humidity: json['current']['humidity'],
    description: json['current']['weather'][0]['description'],
    iconId: json['current']['weather'][0]['icon'],
  );

  Weather toEntity() => Weather(
    timestamp: timestamp,
    temperature: temperature,
    pressure: pressure,
    humidity: humidity,
  );

  @override
  List<Object?> get props => [
    temperature,
    pressure,
    humidity,
  ];
}
