import 'package:equatable/equatable.dart';
import 'package:weather/domain/entities/city.dart';

abstract class LoadWeatherEvent extends Equatable {
  final City city;

  const LoadWeatherEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class LoadWeatherEventCityChanged extends LoadWeatherEvent {
  const LoadWeatherEventCityChanged(super.city);
}
