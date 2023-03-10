import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/datasources/local_data_source.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/domain/entities/city.dart';

import 'package:flutter_test/flutter_test.dart';

import '../tools/tools.dart';

void main() {
  const testCity = City.mainz;
  final String testWeatherString =
      File(fixTestPath('mocks/mock_weather_response.json')).readAsStringSync();
  final testWeatherModel =
      WeatherModel.fromJson(json.decode(testWeatherString));

  group('get saved weather', () {
    test(
      'should return weather model if found',
      () async {
        SharedPreferences.setMockInitialValues(
            {LocalDataSourceImpl.getWeatherKey(testCity): testWeatherString});
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        LocalDataSourceImpl localDataSource = LocalDataSourceImpl(prefs: prefs);

        final result = await localDataSource.getSavedWeather(testCity);

        expect(result.isValue, equals(true));
        expect(result.asValue?.value ?? "", equals(testWeatherModel));
      },
    );

    test(
      'should return error response if nothing is found',
      () async {
        SharedPreferences.setMockInitialValues({});
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        LocalDataSourceImpl localDataSource = LocalDataSourceImpl(prefs: prefs);

        final result = await localDataSource.getSavedWeather(testCity);

        expect(result.isError, equals(true));
      },
    );

    test(
      'should save and load model',
      () async {
        SharedPreferences.setMockInitialValues({});
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        LocalDataSourceImpl localDataSource = LocalDataSourceImpl(prefs: prefs);

        await localDataSource.saveWeather(testCity, testWeatherModel);
        final result = await localDataSource.getSavedWeather(testCity);

        expect(result.isValue, equals(true));
        expect(result.asValue?.value ?? "", equals(testWeatherModel));
      },
    );
  });

  test(
    'should save and load last selected city',
    () async {
      SharedPreferences.setMockInitialValues({});
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      LocalDataSourceImpl localDataSource = LocalDataSourceImpl(prefs: prefs);

      await localDataSource.setLastSelectedCity(testCity);
      final result = await localDataSource.getLastSelectedCity();

      expect(result, equals(testCity));
    },
  );

  test(
    'should return valid default city if nothing was saved',
        () async {
      SharedPreferences.setMockInitialValues({});
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      LocalDataSourceImpl localDataSource = LocalDataSourceImpl(prefs: prefs);

      final result = await localDataSource.getLastSelectedCity();

      expect(result, equals(isNotNull));
    },
  );

}
