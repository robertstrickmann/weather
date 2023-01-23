import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/get_weather_use_case.dart';
import 'package:weather/presentation/bloc/load_weather_events.dart';
import 'package:weather/presentation/bloc/load_weather_states.dart';

class LoadWeatherBloc extends Bloc<LoadWeatherEvent, LoadWeatherState> {
  final LoadWeatherUseCase _loadWeatherUseCase;

  LoadWeatherBloc(this._loadWeatherUseCase)
      : super(const LoadWeatherState(null, false)) {
    on<LoadWeatherEventCityChanged>((event, emit) async {
      final city = event.city;

      emit(const LoadWeatherState(null, true));

      await emit.forEach(_loadWeatherUseCase.execute(city), onData: (event) {
        if (event.requestState == WebRequestState.remoteLoadingUsingCache) {
          return LoadWeatherState(event.result.asValue?.value, true);
        } else {
          return LoadWeatherState(event.result.asValue?.value, false);
        }
      });
    });
  }
}
