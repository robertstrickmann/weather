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
import 'package:weather/presentation/bloc/selected_city_bloc.dart';
import 'package:weather/presentation/bloc/selected_city_events.dart';
import 'package:weather/presentation/bloc/selected_city_states.dart';

import '../mocks/mocks.mocks.dart';
import '../tools/tools.dart';

void main() {
  late SelectedCityBloc selectedCityBloc ;
  late MockLoadSelectedCityUseCase mockLoadSelectedCityUseCase;
  late MockSaveSelectedCityUseCase mockSaveSelectedCityUseCase;

  const City testCity = City.mainz;

  setUp(() {
    mockLoadSelectedCityUseCase = MockLoadSelectedCityUseCase();
    mockSaveSelectedCityUseCase = MockSaveSelectedCityUseCase();
    selectedCityBloc = SelectedCityBloc(mockLoadSelectedCityUseCase, mockSaveSelectedCityUseCase);
  });

  test(
    'should start loading state',
    () async {
      expect(selectedCityBloc.state, SelectedCityStateLoading());
    },
  );

  test(
    'should load saved city',
    () async {
      when(mockLoadSelectedCityUseCase.execute()).thenAnswer((realInvocation) => Future.value(testCity));

      final blocStream = selectedCityBloc.stream;
      selectedCityBloc.add(SelectedCityEventLoadLastSelected());

      expect(
          blocStream,
          emitsInOrder([
            SelectedCityStateLoading(),
            SelectedCityStateCityChanged(testCity),
          ]));
    },
  );

  test(
    'should save city',
        () async {

      final blocStream = selectedCityBloc.stream;
      selectedCityBloc.add(SelectedCityEventSetSelected(testCity));

      expect(
          blocStream,
          emitsInOrder([
            SelectedCityStateCityChanged(testCity),
          ]));
    },
  );

}
