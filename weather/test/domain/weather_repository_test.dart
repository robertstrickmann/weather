import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

import '../mocks/mocks.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tools/tools.dart';

void main() {
  late MockRemoteDataSource remoteDataSource;
  late MockLocalDataSource localDataSource;
  late WeatherRepository weatherRepository;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    localDataSource = MockLocalDataSource();
    weatherRepository =
        WeatherRepositoryImpl(localDataSource, remoteDataSource);
  });

  group('get current weather', () {
    final testWeatherString =
        File(fixTestPath('mocks/mock_weather_response.json'))
            .readAsStringSync();
    final testWeatherModel =
        WeatherModel.fromJson(json.decode(testWeatherString));

    const testCity = City.mainz;

    test(
      'should emit local and remote weather',
      () async {
        when(
          localDataSource.getSavedWeather(testCity),
        ).thenAnswer((_) async => Result.value(testWeatherModel));
        when(
          remoteDataSource.getCurrentWeather(testCity),
        ).thenAnswer((_) async => Result.value(testWeatherModel));

        final resultStream = weatherRepository.getCurrentWeather(testCity);

        expect(
            resultStream,
            emitsInOrder([
              predicate<ResultWithState<Weather>>((result) =>
                  result.requestState ==
                      WebRequestState.remoteLoadingUsingCache &&
                  result.result.asValue?.value == testWeatherModel.toEntity()),
              predicate<ResultWithState<Weather>>((result) =>
                  result.requestState == WebRequestState.remoteSuccess &&
                  result.result.asValue?.value == testWeatherModel.toEntity()),
              emitsDone
            ]));
      },
    );

    test(
      'should emit local weather again if remote fails',
      () async {
        when(
          localDataSource.getSavedWeather(testCity),
        ).thenAnswer((_) async => Result.value(testWeatherModel));
        when(
          remoteDataSource.getCurrentWeather(testCity),
        ).thenAnswer((_) async => Result.error(Exception()));

        final resultStream = weatherRepository.getCurrentWeather(testCity);

        expect(
            resultStream,
            emitsInOrder([
              predicate<ResultWithState<Weather>>((result) =>
                  result.requestState ==
                      WebRequestState.remoteLoadingUsingCache &&
                  result.result.asValue?.value == testWeatherModel.toEntity()),
              predicate<ResultWithState<Weather>>((result) =>
                  result.requestState ==
                      WebRequestState.remoteFailureUsingCache &&
                  result.result.asValue?.value == testWeatherModel.toEntity()),
              emitsDone
            ]));
      },
    );

    test(
      'should emit remote weather only if local fails',
      () async {
        when(
          localDataSource.getSavedWeather(testCity),
        ).thenAnswer((_) async => Result.error(Exception()));
        when(
          remoteDataSource.getCurrentWeather(testCity),
        ).thenAnswer((_) async => Result.value(testWeatherModel));

        final resultStream = weatherRepository.getCurrentWeather(testCity);

        expect(
            resultStream,
            emitsInOrder([
              predicate<ResultWithState<Weather>>((result) =>
                  result.requestState ==
                      WebRequestState.remoteLoadingUsingCache &&
                  result.result.isError),
              predicate<ResultWithState<Weather>>((result) =>
                  result.requestState == WebRequestState.remoteSuccess &&
                  result.result.asValue?.value == testWeatherModel.toEntity()),
              emitsDone
            ]));
      },
    );

    test(
      'should emit error if all fails',
      () async {
        when(
          localDataSource.getSavedWeather(testCity),
        ).thenAnswer((_) async => Result.error(Exception()));
        when(
          remoteDataSource.getCurrentWeather(testCity),
        ).thenAnswer((_) async => Result.error(Exception()));

        final resultStream = weatherRepository.getCurrentWeather(testCity);

        expect(
            resultStream,
            emitsInOrder([
              predicate<ResultWithState<Weather>>((result) =>
                  result.requestState ==
                      WebRequestState.remoteLoadingUsingCache &&
                  result.result.isError),
              predicate<ResultWithState<Weather>>((result) =>
                  result.requestState ==
                      WebRequestState.remoteFailureUsingCache &&
                  result.result.isError),
              emitsDone
            ]));
      },
    );

    test('should save to local if got web response', () async {
      when(
        localDataSource.getSavedWeather(testCity),
      ).thenAnswer((_) async => Result.error(Exception()));
      when(
        remoteDataSource.getCurrentWeather(testCity),
      ).thenAnswer((_) async => Result.value(testWeatherModel));

      final resultStream = weatherRepository.getCurrentWeather(testCity);
      await resultStream.drain();

      verify(localDataSource.saveWeather(any, any));
    });
  });
}
