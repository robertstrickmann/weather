import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
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
  late MockLoadWeatherUseCase mocLoadWeatherUseCase;
  late MockGeolocatorPlatform mockGeoLocator;
  late LoadWeatherBloc weatherBloc;
  const City testCity = City.mainz;
  final testPosition = Position(
      longitude: 1,
      latitude: 1,
      timestamp: DateTime.fromMillisecondsSinceEpoch(1),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  final City testCityCurrentLocation = City(
      name: City.currentLocation.name,
      lat: testPosition.latitude,
      lon: testPosition.longitude);

  final weatherJson = getTestJson('mocks/mock_weather_response.json');
  final testWeatherModel = WeatherModel.fromJson(weatherJson);
  final testWeather = testWeatherModel.toEntity();

  setUp(() {
    mocLoadWeatherUseCase = MockLoadWeatherUseCase();
    mockGeoLocator = MockGeolocatorPlatform();
    weatherBloc = LoadWeatherBloc(
        loadWeatherUseCase: mocLoadWeatherUseCase, geoLocator: mockGeoLocator);
  });

  test(
    'should start loading state',
    () async {
      expect(weatherBloc.state, const LoadWeatherStateLoading());
    },
  );

  test(
    'should recognize repository success',
    () async {
      final List<ResultWithState<Weather>> repositoryEvents = [
        ResultWithState(
            WeatherRequestState.remoteLoadingSuccess, Result.value(testWeather))
      ];
      when(mocLoadWeatherUseCase.execute(any))
          .thenAnswer((_) => Stream.fromIterable(repositoryEvents));

      final blocStream = weatherBloc.stream;
      weatherBloc.add(const LoadWeatherEventCityChanged(testCity));

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherStateLoading(),
            LoadWeatherStateRemoteSuccess(testWeather),
          ]));
    },
  );

  test(
    'should recognize repository failure',
        () async {
      final List<ResultWithState<Weather>> repositoryEvents = [
        ResultWithState(
            WeatherRequestState.remoteLoadingFailed, Result.error(Exception()))
      ];
      when(mocLoadWeatherUseCase.execute(any))
          .thenAnswer((_) => Stream.fromIterable(repositoryEvents));

      final blocStream = weatherBloc.stream;
      weatherBloc.add(const LoadWeatherEventCityChanged(testCity));

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherStateLoading(),
            const LoadWeatherStateRemoteFailure(null),
          ]));
    },
  );

  test(
    'should query weather for current location',
    () async {
      final List<ResultWithState<Weather>> repositoryEvents = [
        ResultWithState(
            WeatherRequestState.remoteLoadingSuccess, Result.value(testWeather))
      ];
      when(mocLoadWeatherUseCase.execute(testCityCurrentLocation))
          .thenAnswer((_) => Stream.fromIterable(repositoryEvents));

      when(mockGeoLocator.getCurrentPosition())
          .thenAnswer((realInvocation) => Future.value(testPosition));
      when(mockGeoLocator.checkPermission()).thenAnswer(
          (realInvocation) => Future.value(LocationPermission.always));
      when(mockGeoLocator.isLocationServiceEnabled())
          .thenAnswer((realInvocation) => Future.value(true));

      weatherBloc.add(const LoadWeatherEventCityChanged(City.currentLocation));
      final blocStream = weatherBloc.stream;

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherStateLoading(),
            LoadWeatherStateRemoteSuccess(testWeather),
          ]));
    },
  );

  setUpLocationTest() {
    final List<ResultWithState<Weather>> repositoryEvents = [
      ResultWithState(
          WeatherRequestState.remoteLoadingSuccess, Result.value(testWeather))
    ];
    when(mocLoadWeatherUseCase.execute(any))
        .thenAnswer((_) => Stream.fromIterable(repositoryEvents));
    when(mockGeoLocator.getCurrentPosition())
        .thenAnswer((realInvocation) => Future.value(testPosition));
  }

  test(
    'should recognize denied location permission',
    () async {
      setUpLocationTest();
      when(mockGeoLocator.isLocationServiceEnabled())
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockGeoLocator.checkPermission()).thenAnswer(
          (realInvocation) => Future.value(LocationPermission.denied));

      weatherBloc.add(const LoadWeatherEventCityChanged(City.currentLocation));
      final blocStream = weatherBloc.stream;

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherStateLoading(),
            const LoadWeatherStateLocationPermissionDenied(),
          ]));
    },
  );

  test(
    'should recognize forever denied location permission',
    () async {
      setUpLocationTest();
      when(mockGeoLocator.isLocationServiceEnabled())
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockGeoLocator.checkPermission()).thenAnswer(
          (realInvocation) => Future.value(LocationPermission.deniedForever));

      weatherBloc.add(const LoadWeatherEventCityChanged(City.currentLocation));
      final blocStream = weatherBloc.stream;

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherStateLoading(),
            const LoadWeatherStateLocationPermissionDeniedForever(),
          ]));
    },
  );

  test(
    'should recognize disabled location service',
    () async {
      setUpLocationTest();
      when(mockGeoLocator.isLocationServiceEnabled())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockGeoLocator.checkPermission()).thenAnswer(
          (realInvocation) => Future.value(LocationPermission.always));

      weatherBloc.add(const LoadWeatherEventCityChanged(City.currentLocation));
      final blocStream = weatherBloc.stream;

      expect(
          blocStream,
          emitsInOrder([
            const LoadWeatherStateLoading(),
            const LoadWeatherStateLocationServiceDisabled(),
          ]));
    },
  );
}
