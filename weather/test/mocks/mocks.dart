import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:weather/data/datasource/local_data_source.dart';
import 'package:weather/data/datasource/remote_data_source.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

@GenerateMocks(
  [
    WeatherRepository,
    RemoteDataSource,
    LocalDataSource
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}

// generate using: flutter pub run build_runner build