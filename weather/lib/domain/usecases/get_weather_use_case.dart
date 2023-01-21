import 'package:async/async.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class LoadWeatherUseCase {
  final WeatherRepository repository;

  LoadWeatherUseCase(this.repository);

  Stream<ResultWithState<Weather>> execute(City city) {
    return repository.getCurrentWeather(city);
  }
}
