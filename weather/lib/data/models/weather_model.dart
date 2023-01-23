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

  static const String _keyTemperature = 'temp';
  static const String _keyCurrent = 'current';
  static const String _keyTimestamp = 'dt';
  static const String _keyPressure = 'pressure';
  static const String _keyHumidity = 'humidity';
  static const String _keyWeather = 'weather';
  static const String _keyDescription = 'description';
  static const String _keyIcon = 'icon';

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        timestamp: json[_keyCurrent][_keyTimestamp],
        temperature: json[_keyCurrent][_keyTemperature],
        pressure: json[_keyCurrent][_keyPressure],
        humidity: json[_keyCurrent][_keyHumidity],
        // TODO: Array can be empty or null?
        description: json[_keyCurrent][_keyWeather][0][_keyDescription],
        iconId: json[_keyCurrent][_keyWeather][0][_keyIcon],
      );

  Map<String, dynamic> toJson() => {
        _keyCurrent: {
          _keyTimestamp: timestamp,
          _keyTemperature: temperature,
          _keyPressure: pressure,
          _keyHumidity: humidity,
          _keyWeather: [
            {_keyDescription: description, _keyIcon: iconId}
          ]
        }
      };

  Weather toEntity() => Weather(
      timestamp: timestamp,
      temperature: temperature,
      pressure: pressure,
      humidity: humidity,
      iconId: iconId);

  @override
  List<Object?> get props =>
      [timestamp, temperature, pressure, humidity, description, iconId];
}
