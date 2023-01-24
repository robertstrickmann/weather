import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/weather_urls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/generated/l10n.dart';
import 'package:weather/presentation/bloc/load_weather_bloc.dart';
import 'package:weather/presentation/bloc/load_weather_states.dart';
import 'package:weather/presentation/ui/city_select_toggle.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          S.of(context).weatherPageTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CitySelectToggle(),
          BlocBuilder<LoadWeatherBloc, LoadWeatherState>(
              builder: (context, state) {
            if (state is LoadWeatherStateLocationServiceDisabled) {
              return LoadingFailedDisplay(
                  message: S.of(context).errorMessageLocationServiceDisabled);
            } else if (state is LoadWeatherStateLocationPermissionDenied) {
              return LoadingFailedDisplay(
                  message: S.of(context).errorMessageLocationPermissionDenied);
            } else if (state
                is LoadWeatherStateLocationPermissionDeniedForever) {
              return LoadingFailedDisplay(
                  message: S
                      .of(context)
                      .errorMessageLocationPermissionDeniedForever);
            } else if (state is LoadWeatherStateLoading) {
              return _buildWeatherDisplayWithSwitcher(null);
            } else if (state is LoadWeatherStateRemoteSuccess &&
                state.weather != null) {
              return _buildWeatherDisplayWithSwitcher(state.weather!);
            } else if (state is LoadWeatherStateRemoteFailure &&
                state.weather != null) {
              return _buildWeatherDisplayWithSwitcher(state.weather!);
            } else {
              return LoadingFailedDisplay(
                  // TODO: ev. auf fehlendes Netzwerk hinweisen
                  message: S.of(context).errorMessageLoadingFailedUndefined);
            }
          })
        ],
      ),
    );
  }

  AnimatedSwitcher _buildWeatherDisplayWithSwitcher(Weather? weather) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: WeatherDisplay(
          weather: weather,
          key: ValueKey<Weather?>(weather),
        ));
  }
}

class LoadingFailedDisplay extends StatelessWidget {
  final String message;

  const LoadingFailedDisplay({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: const EdgeInsets.all(32), child: Text(message)),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Weather? weather;

  const WeatherDisplay({required this.weather, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration:
                          const BoxDecoration(color: Colors.lightBlueAccent),
                      child: weather == null
                          ? const Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: WeatherUrls.getWeatherIconUrl(
                                  weather!.iconId),
                              errorWidget: (context, url, error) => Container(),
                            ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                    child: SizedBox(
                      width: 200,
                      height: 120,
                      child: ColoredBox(
                        color: Colors.lightBlueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: ColoredBox(
                            color: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: weather == null
                                    ? Container()
                                    : WeatherDataList(weather: weather!)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ]);
  }
}

class WeatherDataList extends StatelessWidget {
  final Weather weather;

  const WeatherDataList({required this.weather, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeatherRow(
              label: S.of(context).themperaturLabel,
              text: weather.temperature.toString()),
          WeatherRow(
              label: S.of(context).huminityLabel,
              text: weather.humidity.toString()),
          WeatherRow(
              label: S.of(context).pressureLabel,
              text: weather.pressure.toString()),
          WeatherRow(
              label: S.of(context).timeLabel,
              text: _getFormattedTime(weather.timestamp)),
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
