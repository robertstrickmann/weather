import '../domain/entities/city.dart';

class WeatherUrls {
  static const String weatherApiKey = '06192e20b646128f4fa22ba0f2b98a07';
  static const String weatherBaseUrl =
      'https://api.openweathermap.org/data/3.0/onecall';

  static const String _weatherUrlConfigurations =
      '&exclude=minutely,hourly,daily,alerts&units=metric&appid=$weatherApiKey';

  static String getWeatherUrl(double lat, double lon) =>
      '$weatherBaseUrl?lat=$lat&lon=$lon$_weatherUrlConfigurations';

  static String getWeatherUrlByCity(City city) =>
      getWeatherUrl(city.lat, city.lon);

  static String getWeatherIconUrl(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
