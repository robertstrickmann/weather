import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/weather_urls.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/presentation/bloc/load_weather_bloc.dart';
import 'package:weather/presentation/bloc/load_weather_events.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Wetter",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          CitySelectToggle(),
          Expanded(
            child: WeatherDisplay(
                weather: Weather(
                    timestamp: 1,
                    temperature: 12.0,
                    pressure: 122,
                    humidity: 12,
                    iconId: "04n")),
          )
        ],
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({required this.weather, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_getFormattedTime(weather.timestamp)),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image(
                    image: NetworkImage(
                      WeatherUrls.getWeatherIconUrl(weather.iconId),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WeatherRow(
                            label: "Themperatur:",
                            text: weather.temperature.toString()),
                        WeatherRow(
                            label: "Luftfeuchte:",
                            text: weather.humidity.toString()),
                        WeatherRow(
                            label: "Luftdruck:",
                            text: weather.pressure.toString()),
                      ]),
                ),
              ]),
        ]);
  }

  String _getFormattedTime(int timestampMs) {
    var format = DateFormat('dd.MM.yyyy HH:mm:ss');
    var date = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    return format.format(date);
  }
}

class WeatherRow extends StatelessWidget {
  const WeatherRow({Key? key, required this.label, required this.text})
      : super(key: key);

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 100, child: Text(label)),
        Text(text),
      ],
    );
  }
}

class CitySelectToggle extends StatefulWidget {
  const CitySelectToggle({Key? key}) : super(key: key);

  @override
  State<CitySelectToggle> createState() => _CitySelectToggleState();
}

class _CitySelectToggleState extends State<CitySelectToggle> {
  // TODO: Wählbare Städte zusammen mit letzter Wahl über Bloc aus Repo laden
  // TODO: gewählte Stadt in "lade Wetter" Block speichern
  // TODO "Lade Wetter" darf nur Stadt-ID bekommen. Muss anschließend selbst Koordinaten bestimmen und ggf. Permissions erfragen um GPS anwerfen zu können
  final List<City> _selectableCities = <City>[
    City.mainz,
    City.wiesbaden,
    City.darmstadt,
    City.frankfurtAmMain
  ];
  final List<bool> _isSelectedList = <bool>[true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.vertical,
      isSelected: _isSelectedList,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _isSelectedList.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              _isSelectedList[buttonIndex] = true;
              context.read<LoadWeatherBloc>().add(
                  LoadWeatherEventCityChanged(_selectableCities[buttonIndex]));
            } else {
              _isSelectedList[buttonIndex] = false;
            }
          }
        });
      },
      children: _selectableCities.map((city) => Text(city.name)).toList(),
    );
  }
}
