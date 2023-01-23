import 'package:weather/domain/entities/city.dart';
import 'package:equatable/equatable.dart';

abstract class SelectedCityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectedCityStateLoading extends SelectedCityState {}

class SelectedCityStateCityChanged extends SelectedCityState {
  final City city;

  SelectedCityStateCityChanged(this.city);

  @override
  List<Object?> get props => [city];
}
