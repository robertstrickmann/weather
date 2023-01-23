import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/weather_urls.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/presentation/bloc/load_weather_bloc.dart';
import 'package:weather/presentation/bloc/load_weather_events.dart';
import 'package:weather/presentation/bloc/load_weather_states.dart';
import 'package:weather/presentation/bloc/selected_city_bloc.dart';
import 'package:weather/presentation/bloc/selected_city_events.dart';
import 'package:weather/presentation/bloc/selected_city_states.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Wetter",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CitySelectToggle(),
          BlocBuilder<LoadWeatherBloc, LoadWeatherState>(
              builder: (context, state) {
            return Column(children: [
              Visibility(
                  visible: state.isLoading,
                  maintainAnimation: true,
                  maintainState: true,
                  maintainSize: true,
                  child: const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  )),
              ...state.weather != null
                  ? [
                      AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: WeatherDisplay(
                            weather: state.weather!,
                            key: ValueKey(state.weather),
                          )),
                    ]
                  : state.isLoading
                      ? []
                      : [const LoadingFailedDisplay()]
            ]);
          })
        ],
      ),
    );
  }
}

class LoadingFailedDisplay extends StatelessWidget {
  const LoadingFailedDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
          padding: EdgeInsets.all(32),
          // TODO: Hier könnte man noch genauer unterscheiden ob das Gerät gerade kein Netz hat oder es am Server liegt...
          child: Text("Das Wetter weg. Versuch's noch mal.")),
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
          Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(_getFormattedTime(weather.timestamp))),
          IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                    child: ColoredBox(
                      color: Colors.lightBlueAccent,
                      child: Image(
                        image: NetworkImage(
                          WeatherUrls.getWeatherIconUrl(weather.iconId),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                    child: ColoredBox(
                      color: Colors.lightBlueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: ColoredBox(
                          color: Colors.white,
                          child: Padding(
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
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ]);
  }

  String _getFormattedTime(int timestampMs) {
    var format = DateFormat('HH:mm:ss');
    var date = DateTime.fromMillisecondsSinceEpoch(timestampMs * 1000);
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

class CitySelectToggle extends StatelessWidget {
  CitySelectToggle({Key? key}) : super(key: key);

  final List<City> _selectableCities = <City>[
    City.mainz,
    City.wiesbaden,
    City.darmstadt,
    City.frankfurtAmMain
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCityBloc, SelectedCityState>(
        builder: (context, state) {
      List<bool> isSelectedList;
      if (state is SelectedCityStateCityChanged) {
        isSelectedList =
            _selectableCities.map((e) => e.name == state.city.name).toList();
        context
            .read<LoadWeatherBloc>()
            .add(LoadWeatherEventCityChanged(state.city));
      } else {
        isSelectedList = _selectableCities.map((e) => false).toList();
      }

      return ToggleButtons(
        direction: Axis.vertical,
        isSelected: isSelectedList,
        onPressed: (int index) {
          context
              .read<SelectedCityBloc>()
              .add(SelectedCityEventSetSelected(_selectableCities[index]));
        },
        children: _selectableCities.map((city) => Text(city.name)).toList(),
      );
    });
  }
}
