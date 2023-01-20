import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/datasource/local_data_source.dart';
import 'package:weather/data/datasource/remote_data_source.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/weather_urls.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

import '../mocks/mocks.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

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

    final testCity = City.mainz;

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

        //expect(resultStream, emitsInOrder([]));
        resultStream.listen(
          expectAsync1(
              (value) => expect(
                    value.result.asValue?.value,
                    testWeatherModel,
                  ),
              count: 2),
        );
      },
    );

    // TODO: Local only
    // TODO: remote only
    // TODO: Nothing at all
  });
}
