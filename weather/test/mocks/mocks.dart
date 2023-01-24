import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:weather/data/datasources/local_data_source.dart';
import 'package:weather/data/datasources/remote_data_source.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/get_last_selected_city_use_case.dart';
import 'package:weather/domain/usecases/get_weather_use_case.dart';
import 'package:weather/domain/usecases/set_last_selected_city_use_case.dart';

@GenerateNiceMocks([
  MockSpec<WeatherRepository>(),
  MockSpec<RemoteDataSource>(),
  MockSpec<LocalDataSource>(),
  MockSpec<LoadWeatherUseCase>(),
  MockSpec<GeolocatorPlatform>(),
  MockSpec<SaveSelectedCityUseCase>(),
  MockSpec<LoadSelectedCityUseCase>(),
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}

// generate using: flutter pub run build_runner build
