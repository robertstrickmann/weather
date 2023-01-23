import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/datasources/local_data_source.dart';
import 'package:weather/data/datasources/remote_data_source.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/get_last_selected_city_use_case.dart';
import 'package:weather/domain/usecases/get_weather_use_case.dart';
import 'package:weather/domain/usecases/set_last_selected_city_use_case.dart';
import 'package:weather/presentation/bloc/load_weather_bloc.dart';
import 'package:weather/presentation/bloc/selected_city_bloc.dart';

final locator = GetIt.instance;

init() async {
  // bloc
  locator.registerFactory(() => LoadWeatherBloc(locator()));
  locator.registerFactory(() => SelectedCityBloc(locator(), locator()));

  // usecases
  locator.registerLazySingleton(() => LoadWeatherUseCase(locator()));
  locator.registerLazySingleton(() => LoadSelectedCityUseCase(locator()));
  locator.registerLazySingleton(() => SaveSelectedCityUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(locator(), locator()),
  );

  // data
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(locator()),
  );

  // External
  locator.registerLazySingleton(() => http.Client());
  locator.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
}
