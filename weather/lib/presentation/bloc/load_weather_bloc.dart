import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/domain/usecases/get_weather_use_case.dart';
import 'package:weather/presentation/bloc/load_weather_events.dart';
import 'package:weather/presentation/bloc/load_weather_states.dart';

class LoadWeatherBloc extends Bloc<LoadWeatherEvent, LoadWeatherState> {
  final LoadWeatherUseCase loadWeatherUseCase;
  final GeolocatorPlatform geoLocator;

  LoadWeatherBloc({required this.loadWeatherUseCase, required this.geoLocator})
      : super(const LoadWeatherStateLoading()) {
    on<LoadWeatherEventCityChanged>((event, emit) async {
      var city = event.city;

      emit(const LoadWeatherStateLoading());

      if (city == City.currentLocation) {
        await loadWeatherForCurrentLocation(emit);
      } else {
        await loadWeather(emit, city);
      }
    });
  }

  Future<void> loadWeatherForCurrentLocation(
      Emitter<LoadWeatherState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await geoLocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(const LoadWeatherStateLocationServiceDisabled());
      return;
    }

    permission = await geoLocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geoLocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(const LoadWeatherStateLocationPermissionDenied());
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(const LoadWeatherStateLocationPermissionDeniedForever());
      return;
    }

    var position = await geoLocator.getCurrentPosition();
    var localCity = City(
        name: City.currentLocation.name,
        lat: position.latitude,
        lon: position.longitude);
    await loadWeather(emit, localCity);
  }

  Future<void> loadWeather(
      Emitter<LoadWeatherState> emit, City localCity) async {
    await emit.forEach(loadWeatherUseCase.execute(localCity), onData: (event) {
      if (event.result.isValue) {
        return LoadWeatherStateRemoteSuccess(event.result.asValue?.value);
      } else {
        return LoadWeatherStateRemoteFailure(event.result.asValue?.value);
      }
    });
  }
}
