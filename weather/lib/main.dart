import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/bloc/load_weather_bloc.dart';
import 'package:weather/presentation/ui/weather_page.dart';
import 'locator.dart' as injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injection.init();
  await injection.locator.allReady();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injection.locator<LoadWeatherBloc>())
      ],
      child: MaterialApp(
        title: 'Weather',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const WeatherPage(),
      ),
    );
  }
}
