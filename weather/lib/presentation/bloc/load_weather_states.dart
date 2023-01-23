import 'package:weather/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class LoadWeatherState extends Equatable {
  final Weather? weather;
  final bool isLoading;

  const LoadWeatherState(this.weather, this.isLoading);

  @override
  List<Object?> get props => [weather, isLoading];
}
