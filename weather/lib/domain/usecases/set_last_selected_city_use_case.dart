import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class SaveSelectedCityUseCase {
  final WeatherRepository repository;

  SaveSelectedCityUseCase(this.repository);

  Future execute(City city) async => repository.setLastSelectedCity(city);
}
