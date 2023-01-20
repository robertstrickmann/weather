import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/weather_urls.dart';
import 'package:weather/domain/entities/city.dart';

void main() {
  test('should create valid weather url for city', () async {
    Uri weatherUri = Uri.parse(WeatherUrls.getWeatherUrlByCity(City.mainz));
    expect(
        City.mainz.lat.toString(), equals(weatherUri.queryParameters['lat']));
    expect(
        City.mainz.lon.toString(), equals(weatherUri.queryParameters['lon']));
    expect(
        WeatherUrls.weatherApiKey, equals(weatherUri.queryParameters['appid']));
  });
}
