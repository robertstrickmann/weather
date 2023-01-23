import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/city_model.dart';
import 'package:weather/domain/entities/city.dart';

void main() {
  const City testCity = City(name: "Test", lat: 1.1, lon: 2.2);
  const testCityModel = CityModel(name: "Test", lat: 1.1, lon: 2.2);

  test(
    'should create City from CityModel',
        () async {
      final created = testCityModel.toEntity();
      expect(created, equals(testCity));
    },
  );

  test(
    'should create CityModel from City',
        () async {
      final created = CityModel.fromEntity(testCity);
      expect(created, equals(testCityModel));
    },
  );

  test(
    'should transform model to json and back',
    () async {
      final createdJson = testCityModel.toJson();
      final createdModel = CityModel.fromJson(createdJson);

      expect(createdModel, equals(testCityModel));
    },
  );
}
