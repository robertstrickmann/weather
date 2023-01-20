import 'package:async/async.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Result<Weather>> execute(double lat, double lon) {
    return repository.getCurrentWeather(lat, lon);
  }
}
