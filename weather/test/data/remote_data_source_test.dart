import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:weather/data/datasources/remote_data_source.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/weather_urls.dart';
import 'package:weather/domain/entities/city.dart';

import '../mocks/mocks.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../tools/tools.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = RemoteDataSourceImpl(mockHttpClient);
  });

  group('get current weather', () {
    final testWeatherString =
        File(fixTestPath('mocks/mock_weather_response.json'))
            .readAsStringSync();
    final testWeatherModel =
        WeatherModel.fromJson(json.decode(testWeatherString));
    final testCity = City.mainz;

    test(
      'should return weather model on success',
      () async {
        when(
          mockHttpClient
              .get(Uri.parse(WeatherUrls.getWeatherUrlByCity(testCity))),
        ).thenAnswer(
          (_) async => http.Response(testWeatherString, 200),
        );

        final result = await remoteDataSource.getCurrentWeather(testCity);

        expect(result.isValue, equals(true));
        expect(result.asValue?.value ?? "", equals(testWeatherModel));
      },
    );

    test(
      'should return error response on 404 or other',
      () async {
        when(
          mockHttpClient
              .get(Uri.parse(WeatherUrls.getWeatherUrlByCity(testCity))),
        ).thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        final result = await remoteDataSource.getCurrentWeather(testCity);

        expect(result.isError, equals(true));
      },
    );
  });
}
