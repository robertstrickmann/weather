import 'package:async/async.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Stream<ResultWithState<Weather>> getCurrentWeather(City city);

  Future<City> getLastSelectedCity();

  Future setLastSelectedCity(City city);
}

enum WeatherRequestState {
  remoteLoadingFailed,
  remoteLoadingSuccess,
}

class ResultWithState<T> {
  WeatherRequestState requestState;
  Result<T> result;

  ResultWithState(this.requestState, this.result);
}
