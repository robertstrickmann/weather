import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class LoadSelectedCityUseCase {
  final WeatherRepository repository;

  LoadSelectedCityUseCase(this.repository);

  Future<City> execute() async => repository.getLastSelectedCity();
}
