import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/weather_urls.dart';
import 'package:weather/domain/entities/city.dart';

abstract class LocalDataSource {
  Future<Result<WeatherModel>> getSavedWeather(City city);

  Future saveWeather(City city, WeatherModel weather);
}

class LocalDataSourceImpl implements LocalDataSource {
  static const String weatherKeyPrefix = "WEATHER_";
  final SharedPreferences prefs;

  LocalDataSourceImpl(this.prefs);

  static String getWeatherKey(City city) => '$weatherKeyPrefix${city.name}';

  @override
  Future<Result<WeatherModel>> getSavedWeather(City city) async {
    String? storedWeatherJson =
    prefs.getString(getWeatherKey(city));
    if (storedWeatherJson == null) {
      return Result.error(Exception("no value stored"));
    } else {
      return Result.value(
          WeatherModel.fromJson(json.decode(storedWeatherJson)));
    }
  }

  @override
  Future saveWeather(City city, WeatherModel weather) async {
    prefs.setString(getWeatherKey(city), weather.toJson().toString());
  }
}
