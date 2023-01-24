import 'package:async/async.dart';
import 'package:weather/data/datasources/local_data_source.dart';
import 'package:weather/data/datasources/remote_data_source.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  LocalDataSource localDataSource;
  RemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Stream<ResultWithState<Weather>> getCurrentWeather(City city) async* {

    Result<WeatherModel> remoteResult =
        await remoteDataSource.getCurrentWeather(city);
    WeatherModel? remoteWeather = remoteResult.asValue?.value;

    if (remoteWeather != null) {
      await localDataSource.saveWeather(city, remoteWeather);
      yield ResultWithState(WeatherRequestState.remoteLoadingSuccess,
          Result.value(remoteWeather.toEntity()));
    } else {
      Result<WeatherModel> localResult =
          await localDataSource.getSavedWeather(city);
      Weather? savedWeather = localResult.asValue?.value.toEntity();

      if (savedWeather != null) {
        yield ResultWithState(WeatherRequestState.remoteLoadingFailed,
            Result.value(savedWeather));
      } else {
        yield ResultWithState(WeatherRequestState.remoteLoadingFailed,
            Result.error(Exception("No weather found")));
      }
    }
  }

  @override
  Future<City> getLastSelectedCity() async =>
      localDataSource.getLastSelectedCity();

  @override
  Future setLastSelectedCity(City city) async =>
      localDataSource.setLastSelectedCity(city);
}
