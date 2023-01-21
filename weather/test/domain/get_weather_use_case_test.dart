import 'package:flutter_test/flutter_test.dart';
import 'package:weather/domain/usecases/get_weather_use_case.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late LoadWeatherUseCase getWeatherUseCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeatherUseCase = LoadWeatherUseCase(mockWeatherRepository);
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
}
