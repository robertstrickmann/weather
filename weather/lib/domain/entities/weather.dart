import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.timestamp,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });

  final int timestamp;
  final double temperature;
  final int pressure;
  final int humidity;

  @override
  List<Object?> get props => [
        timestamp,
        temperature,
        pressure,
        humidity,
      ];
}
