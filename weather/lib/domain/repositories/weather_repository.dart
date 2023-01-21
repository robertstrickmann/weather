import 'package:async/async.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Stream<ResultWithState<Weather>> getCurrentWeather(City city);
}

enum WebRequestState{
  remoteLoadingUsingCache,
  remoteSuccess,
  remoteFailureUsingCache
}

class ResultWithState<T>{
  WebRequestState requestState;
  Result<T> result;

  ResultWithState(this.requestState, this.result);
}
