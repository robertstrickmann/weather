import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/usecases/get_current_weather.dart';

import '../mocks/mocks.mocks.dart';
import '../tools/tools.dart';

void main() {
  const testWeather = Weather(
    timestamp: 1,
    temperature: 0.78,
    pressure: 1007,
    humidity: 88,
  );

  const testWeatherModel = WeatherModel(
      timestamp: 1,
      temperature: 0.78,
      pressure: 1007,
      humidity: 88,
      description: "any",
      iconId: "04n");

  const testLongitude = 3.5;
  const testLatitude = 3.5;

  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather getWeatherUseCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeatherUseCase = GetCurrentWeather(mockWeatherRepository);
  });

  // FIXME: sinnfreier Test
  test(
    'should get current weather',
    () async {
      when(mockWeatherRepository.getCurrentWeather(testLongitude, testLatitude))
          .thenAnswer((_) async => Result.value(testWeather));

      final result =
          await getWeatherUseCase.execute(testLongitude, testLatitude);

      expect(result, equals(Result.value(testWeather)));
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
  });
}
