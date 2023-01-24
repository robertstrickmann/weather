import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/get_weather_use_case.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late LoadWeatherUseCase getWeatherUseCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeatherUseCase = LoadWeatherUseCase(mockWeatherRepository);
  });

  const City testCity = City.mainz;

  test(
    'should save city when loading weather',
    () async {
      final resultStream = getWeatherUseCase.execute(testCity);
      await resultStream.drain();

      verify(mockWeatherRepository.setLastSelectedCity(testCity));
    },
  );

  test(
    'should load weather from repo',
    () async {
      var testResult = ResultWithState<Weather>(
          WeatherRequestState.remoteLoadingSuccess,
          Result<Weather>.value(const Weather(
              timestamp: 1,
              temperature: 1,
              pressure: 1,
              humidity: 1,
              iconId: "")));
      when(mockWeatherRepository.getCurrentWeather(any))
          .thenAnswer((realInvocation) => Stream.fromIterable([testResult]));
      final resultStream = getWeatherUseCase.execute(testCity);

      expect(
          resultStream,
          emitsInOrder([
            predicate<ResultWithState<Weather>>((result) =>
                result.requestState == testResult.requestState &&
                result.result.asValue?.value ==
                    testResult.result.asValue?.value),
            emitsDone
          ]));
    },
  );
}
