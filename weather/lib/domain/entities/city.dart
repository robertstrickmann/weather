class City {
  String name;
  double lat;
  double lon;

  static final City mainz = City("Mainz", 49.992863, 8.247253);
  static final City darmstadt = City("Darmstadt", 49.872826, 8.651193);
  static final City wiesbaden = City("Wiesbaden", 50.078217, 8.239761);
  static final City frankfurtAmMain =
      City("Frankfurt am Main", 50.078217, 8.239761);
  static final City currentLocation = City("Aktuelle Position", 0, 0);

  City(this.name, this.lat, this.lon);
}
