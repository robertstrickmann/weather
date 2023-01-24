import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/constants.dart';
import 'package:weather/domain/entities/city.dart';
import 'package:weather/presentation/bloc/load_weather_bloc.dart';
import 'package:weather/presentation/bloc/load_weather_events.dart';
import 'package:weather/presentation/bloc/selected_city_bloc.dart';
import 'package:weather/presentation/bloc/selected_city_events.dart';
import 'package:weather/presentation/bloc/selected_city_states.dart';

class CitySelectToggle extends StatelessWidget {
  CitySelectToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCityBloc, SelectedCityState>(
        builder: (context, state) {
      List<bool> isSelectedList;
      if (state is SelectedCityStateCityChanged) {
        isSelectedList =
            selectableCities.map((e) => e.name == state.city.name).toList();
        context
            .read<LoadWeatherBloc>()
            .add(LoadWeatherEventCityChanged(state.city));
      } else {
        isSelectedList = selectableCities.map((e) => false).toList();
      }

      return ToggleButtons(
        direction: Axis.vertical,
        isSelected: isSelectedList,
        onPressed: (int index) {
          context
              .read<SelectedCityBloc>()
              .add(SelectedCityEventSetSelected(selectableCities[index]));
        },
        children: selectableCities.map((city) => Text(city.name)).toList(),
      );
    });
  }
}
