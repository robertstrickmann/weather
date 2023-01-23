import 'package:async/async.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Stream<ResultWithState<Weather>> getCurrentWeather(City city);

  Future<City> getLastSelectedCity();

  Future setLastSelectedCity(City city);
}

enum RequestState {
  loadingRemoteDeliveringCache,
  remoteLoadingFailedDeliveringCache,
  remoteLoadingSuccess
}

class ResultWithState<T> {
  RequestState requestState;
  Result<T> result;

  ResultWithState(this.requestState, this.result);
}
