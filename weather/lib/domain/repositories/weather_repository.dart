import 'package:async/async.dart';
import 'package:weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Result<Weather>> getCurrentWeather(double lat, double lon);
}
