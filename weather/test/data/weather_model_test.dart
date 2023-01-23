import 'package:flutter_test/flutter_test.dart';
import '../tools/tools.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';

void main() {
  const testWeather = Weather(
    timestamp: 1674155700,
    temperature: 0.78,
    pressure: 1007,
    humidity: 88,
    iconId: "04n"
  );

  const testWeatherModel = WeatherModel(
      timestamp: 1674155700,
      temperature: 0.78,
      pressure: 1007,
      humidity: 88,
      description: "overcast clouds",
      iconId: "04n");

  final testCity = City.mainz;

  test(
    'should read WeatherModel from json',
    () async {
      final weatherJson = getTestJson('mocks/mock_weather_response.json');
      final createdModel = WeatherModel.fromJson(weatherJson);

      expect(createdModel, equals(testWeatherModel));
    },
  );

  test(
    'should create Weather from WeatherModel',
    () async {
      final createdWeather = testWeatherModel.toEntity();
      expect(createdWeather, equals(testWeather));
    },
  );

  test(
    'should transform model to json and back',
    () async {
      final weatherJson = getTestJson('mocks/mock_weather_response.json');
      final model = WeatherModel.fromJson(weatherJson);

      final createdJson = model.toJson();
      final createdModel = WeatherModel.fromJson(createdJson);

      expect(createdModel, equals(testWeatherModel));
    },
  );
}
