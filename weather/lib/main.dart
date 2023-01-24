import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/generated/l10n.dart';
import 'package:weather/presentation/bloc/load_weather_bloc.dart';
import 'package:weather/presentation/bloc/selected_city_bloc.dart';
import 'package:weather/presentation/bloc/selected_city_events.dart';
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
    var selectCityBloc = injection.locator<SelectedCityBloc>();
    selectCityBloc.add(SelectedCityEventLoadLastSelected());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injection.locator<LoadWeatherBloc>()),
        BlocProvider(create: (_) => selectCityBloc)
      ],
      child: MaterialApp(
        onGenerateTitle: (context) => S.of(context).appTitle,
        supportedLocales: const [Locale('de', '')],
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const WeatherPage(),
      ),
    );
  }
}
