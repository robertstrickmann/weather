import 'package:async/async.dart';
import 'package:weather/data/datasource/local_data_source.dart';
import 'package:weather/data/datasource/remote_data_source.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Stream<ResultWithState<Weather>> getCurrentWeather(City city);
}

enum WebRequestState{
  loading,
  success,
  failure
}

class ResultWithState<T>{
  WebRequestState requestState;
  Result<T> result;

  ResultWithState(this.requestState, this.result);
}

class WeatherRepositoryImpl implements WeatherRepository{
  LocalDataSource localDataSource;
  RemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Stream<ResultWithState<Weather>> getCurrentWeather(City city) {
    // TODO: implement getCurrentWeather
    throw UnimplementedError();
  }
}