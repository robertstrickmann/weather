import 'package:weather/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class LoadWeatherState extends Equatable {
  const LoadWeatherState();

  @override
  List<Object?> get props => [];
}

class LoadWeatherStateLoading extends LoadWeatherState {
  const LoadWeatherStateLoading();
}

class LoadWeatherStateLocationPermissionDenied extends LoadWeatherState {
  const LoadWeatherStateLocationPermissionDenied();
}

class LoadWeatherStateLocationPermissionDeniedForever extends LoadWeatherState {
  const LoadWeatherStateLocationPermissionDeniedForever();
}

class LoadWeatherStateLocationServiceDisabled extends LoadWeatherState {
  const LoadWeatherStateLocationServiceDisabled();
}

class LoadWeatherStateRemoteSuccess extends LoadWeatherState {
  final Weather? weather;

  const LoadWeatherStateRemoteSuccess(this.weather);

  @override
  List<Object?> get props => [weather];
}

class LoadWeatherStateRemoteFailure extends LoadWeatherState {
  final Weather? weather;

  const LoadWeatherStateRemoteFailure(this.weather);

  @override
  List<Object?> get props => [weather];
}
