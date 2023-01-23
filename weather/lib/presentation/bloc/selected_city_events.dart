import 'package:equatable/equatable.dart';
import 'package:weather/domain/entities/city.dart';

abstract class SelectedCityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectedCityEventLoadLastSelected extends SelectedCityEvent {
  @override
  List<Object?> get props => [];
}

class SelectedCityEventSetSelected extends SelectedCityEvent {
  final City city;

  SelectedCityEventSetSelected(this.city);

  @override
  List<Object?> get props => [city];
}
