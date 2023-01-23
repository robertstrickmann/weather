import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name;
  final double lat;
  final double lon;

  static const City mainz = City(name: "Mainz", lat: 49.992863, lon: 8.247253);
  static const City darmstadt =
      City(name: "Darmstadt", lat: 49.872826, lon: 8.651193);
  static const City wiesbaden =
      City(name: "Wiesbaden", lat: 50.078217, lon: 8.239761);
  static const City frankfurtAmMain =
      City(name: "Frankfurt am Main", lat: 50.078217, lon: 8.239761);
  static const City currentLocation =
      City(name: "Aktuelle Position", lat: 0, lon: 0);

  const City({required this.name, required this.lat, required this.lon});

  @override
  List<Object?> get props => [name, lat, lon];
}
