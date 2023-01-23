import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/entities/weather.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/presentation/bloc/load_weather_bloc.dart';
import 'package:weather/presentation/bloc/load_weather_events.dart';
import 'package:weather/presentation/bloc/load_weather_states.dart';

import '../mocks/mocks.mocks.dart';
import '../tools/tools.dart';

void main() {
  late MockLoadWeatherUseCase mockLoadWeatherUseCase;
  late LoadWeatherBloc weatherBloc;
  City testCity = City.mainz;

  final weatherJson = getTestJson('mocks/mock_weather_response.json');
  final testWeatherModel = WeatherModel.fromJson(weatherJson);
  final testWeather = testWeatherModel.toEntity();

  setUp(() {
    mockLoadWeatherUseCase = MockLoadWeatherUseCase();
    weatherBloc = LoadWeatherBloc(mockLoadWeatherUseCase);
  });

  test(
    'should start in empty non loading state',
    () async {
      expect(weatherBloc.state, const LoadWeatherState(null, false));
    },
  );

  test(
    'should emit matching local success and remote success',
    () async {
      final List<ResultWithState<Weather>> repositoryEvents = [
        ResultWithState(
            WebRequestState.remoteLoadingUsingCache, Result.value(testWeather)),
        ResultWithState(
            WebRequestState.remoteSuccess, Result.value(testWeather))
      ];
      when(mockLoadWeatherUseCase.execute(testCity))
          .thenAnswer((_) => Stream.fromIterable(repositoryEvents));

      final blocStream = weatherBloc.stream;
      weatherBloc.add(LoadWeatherEventCityChanged(testCity));

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherState(null, true),
            LoadWeatherState(testWeather, true),
            LoadWeatherState(testWeather, false),
          ]));
    },
  );

  test(
    'should emit matching local success and remote failure',
    () async {
      final List<ResultWithState<Weather>> repositoryEvents = [
        ResultWithState(
            WebRequestState.remoteLoadingUsingCache, Result.value(testWeather)),
        ResultWithState(
            WebRequestState.remoteFailureUsingCache, Result.value(testWeather))
      ];
      when(mockLoadWeatherUseCase.execute(testCity))
          .thenAnswer((_) => Stream.fromIterable(repositoryEvents));

      final blocStream = weatherBloc.stream;
      weatherBloc.add(LoadWeatherEventCityChanged(testCity));

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherState(null, true),
            LoadWeatherState(testWeather, true),
            LoadWeatherState(testWeather, false),
          ]));
    },
  );

  test(
    'should emit matching local failure and remote success',
    () async {
      final List<ResultWithState<Weather>> repositoryEvents = [
        ResultWithState(
            WebRequestState.remoteLoadingUsingCache, Result.error(Exception())),
        ResultWithState(
            WebRequestState.remoteSuccess, Result.value(testWeather))
      ];
      when(mockLoadWeatherUseCase.execute(testCity))
          .thenAnswer((_) => Stream.fromIterable(repositoryEvents));

      final blocStream = weatherBloc.stream;
      weatherBloc.add(LoadWeatherEventCityChanged(testCity));

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherState(null, true),
            // const LoadWeatherState(null, true), // no emission of duplicates
            LoadWeatherState(testWeather, false),
          ]));
    },
  );

  test(
    'should emit matching local failure and remote failure',
    () async {
      final List<ResultWithState<Weather>> repositoryEvents = [
        ResultWithState(
            WebRequestState.remoteLoadingUsingCache, Result.error(Exception())),
        ResultWithState(
            WebRequestState.remoteFailureUsingCache, Result.error(Exception()))
      ];
      when(mockLoadWeatherUseCase.execute(testCity))
          .thenAnswer((_) => Stream.fromIterable(repositoryEvents));

      final blocStream = weatherBloc.stream;
      weatherBloc.add(LoadWeatherEventCityChanged(testCity));

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherState(null, true),
            //const LoadWeatherState(null, true), // no emission of duplicates
            const LoadWeatherState(null, false),
          ]));
    },
  );
}
