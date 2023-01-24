import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/weather_urls.dart';
import 'package:weather/domain/entities/city.dart';

abstract class RemoteDataSource {
  Future<Result<WeatherModel>> getCurrentWeather(City city);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl(this.client);

  @override
  Future<Result<WeatherModel>> getCurrentWeather(City city) async {
    Uri weatherUri = Uri.parse(WeatherUrls.getWeatherUrlByCity(city));
    try {
      final response = await client.get(weatherUri);
      if (response.statusCode == 200) {
        WeatherModel weather =
            WeatherModel.fromJson(json.decode(response.body));
        return Result.value(weather);
      } else {
        return Result.error(Exception(response.reasonPhrase));
      }
    } catch (e) {
      return Result.error(e);
    }
  }
}
