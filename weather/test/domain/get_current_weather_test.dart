import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/usecases/get_current_weather.dart';

import '../mocks/mocks.mocks.dart';
import '../tools/tools.dart';

void main() {
  const testWeather = Weather(
    timestamp: 1674155700,
    temperature: 0.78,
    pressure: 1007,
    humidity: 88,
  );

  const testWeatherModel = WeatherModel(
      timestamp: 1674155700,
      temperature: 0.78,
      pressure: 1007,
      humidity: 88,
      description: "overcast clouds",
      iconId: "04n");

  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather getWeatherUseCase;
  final testCity = City.mainz;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeatherUseCase = GetCurrentWeather(mockWeatherRepository);
  });

  // FIXME: sinnfreier Test
  test(
    'should get current weather',
    () async {
// FIXME: same test as repository. A bit boring...
      /*
      when(mockWeatherRepository.getCurrentWeather(testCity))
          .thenAnswer((_) async => Result.value(testWeather));

      final result =
          await getWeatherUseCase.execute(testLongitude, testLatitude);

      expect(result, equals(Result.value(testWeather)));
      */
    },
  );

  group('can read weather', () {
    test(
      'can read WeatherModel from json',
      () async {
        final weatherJson = getTestJson('mocks/mock_weather_response.json');
        final createdModel = WeatherModel.fromJson(weatherJson);

        expect(createdModel, equals(testWeatherModel));
      },
    );

    test(
      'can create Weather from WeatherModel',
      () async {
        final createdWeather = testWeatherModel.toEntity();
        expect(createdWeather, equals(testWeather));
      },
    );

    test(
      'can transform model to json and back',
      () async {
        final weatherJson = getTestJson('mocks/mock_weather_response.json');
        final model = WeatherModel.fromJson(weatherJson);

        final createdJson = model.toJson();
        final createdModel = WeatherModel.fromJson(createdJson);

        expect(createdModel, equals(testWeatherModel));
      },
    );
  });
}
