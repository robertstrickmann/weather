import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/usecases/get_last_selected_city_use_case.dart';
import 'package:weather/domain/usecases/set_last_selected_city_use_case.dart';
import 'package:weather/presentation/bloc/selected_city_events.dart';
import 'package:weather/presentation/bloc/selected_city_states.dart';

class SelectedCityBloc extends Bloc<SelectedCityEvent, SelectedCityState> {
  final LoadSelectedCityUseCase _loadSelectedCityUseCase;
  final SaveSelectedCityUseCase _saveSelectedCityUseCase;

  SelectedCityBloc(this._loadSelectedCityUseCase, this._saveSelectedCityUseCase)
      : super(SelectedCityStateLoading()) {
    on<SelectedCityEventLoadLastSelected>(
      (event, emit) async {
        emit(SelectedCityStateLoading());
        emit(SelectedCityStateCityChanged(
            await _loadSelectedCityUseCase.execute()));
      },
    );
    on<SelectedCityEventSetSelected>(
      (event, emit) async {
        await _saveSelectedCityUseCase.execute(event.city);
        emit(SelectedCityStateCityChanged(event.city));
      },
    );
  }
}
