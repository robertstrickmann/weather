import 'package:equatable/equatable.dart';
import 'package:weather/domain/entities/city.dart';

class CityModel extends Equatable {
  const CityModel({
    required this.name,
    required this.lat,
    required this.lon,
  });

  final String name;
  final double lat;
  final double lon;

  static const String _keyLat = 'lat';
  static const String _keyName = 'name';
  static const String _keyLon = 'lon';

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        name: json[_keyName],
        lat: json[_keyLat],
        lon: json[_keyLon],
      );

  Map<String, dynamic> toJson() => {
        _keyName: name,
        _keyLat: lat,
        _keyLon: lon,
      };

  City toEntity() => City(name: name, lat: lat, lon: lon);

  factory CityModel.fromEntity(City city) =>
      CityModel(name: city.name, lat: city.lat, lon: city.lon);

  @override
  List<Object?> get props => [name, lat, lon];
}
