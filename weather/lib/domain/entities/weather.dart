import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather(
      {required this.timestamp,
      required this.temperature,
      required this.pressure,
      required this.humidity,
      required this.iconId});

  final int timestamp;
  final double temperature;
  final int pressure;
  final int humidity;
  final String iconId;

  @override
  List<Object?> get props =>
      [timestamp, temperature, pressure, humidity, iconId];
}
