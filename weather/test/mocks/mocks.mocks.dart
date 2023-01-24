// Mocks generated by Mockito 5.3.2 from annotations
// in weather/test/mocks/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i17;
import 'dart:typed_data' as _i18;

import 'package:async/async.dart' as _i3;
import 'package:geolocator_platform_interface/src/enums/enums.dart' as _i14;
import 'package:geolocator_platform_interface/src/geolocator_platform_interface.dart'
    as _i13;
import 'package:geolocator_platform_interface/src/models/models.dart' as _i5;
import 'package:http/http.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:weather/data/datasources/local_data_source.dart' as _i11;
import 'package:weather/data/datasources/remote_data_source.dart' as _i9;
import 'package:weather/data/models/weather_model.dart' as _i10;
import 'package:weather/domain/entities/city.dart' as _i2;
import 'package:weather/domain/entities/weather.dart' as _i8;
import 'package:weather/domain/repositories/weather_repository.dart' as _i4;
import 'package:weather/domain/usecases/get_last_selected_city_use_case.dart'
    as _i16;
import 'package:weather/domain/usecases/get_weather_use_case.dart' as _i12;
import 'package:weather/domain/usecases/set_last_selected_city_use_case.dart'
    as _i15;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCity_0 extends _i1.SmartFake implements _i2.City {
  _FakeCity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResult_1<T> extends _i1.SmartFake implements _i3.Result<T> {
  _FakeResult_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeatherRepository_2 extends _i1.SmartFake
    implements _i4.WeatherRepository {
  _FakeWeatherRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePosition_3 extends _i1.SmartFake implements _i5.Position {
  _FakePosition_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_4 extends _i1.SmartFake implements _i6.Response {
  _FakeResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_5 extends _i1.SmartFake
    implements _i6.StreamedResponse {
  _FakeStreamedResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i4.WeatherRepository {
  @override
  _i7.Stream<_i4.ResultWithState<_i8.Weather>> getCurrentWeather(
          _i2.City? city) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentWeather,
          [city],
        ),
        returnValue: _i7.Stream<_i4.ResultWithState<_i8.Weather>>.empty(),
        returnValueForMissingStub:
            _i7.Stream<_i4.ResultWithState<_i8.Weather>>.empty(),
      ) as _i7.Stream<_i4.ResultWithState<_i8.Weather>>);
  @override
  _i7.Future<_i2.City> getLastSelectedCity() => (super.noSuchMethod(
        Invocation.method(
          #getLastSelectedCity,
          [],
        ),
        returnValue: _i7.Future<_i2.City>.value(_FakeCity_0(
          this,
          Invocation.method(
            #getLastSelectedCity,
            [],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i2.City>.value(_FakeCity_0(
          this,
          Invocation.method(
            #getLastSelectedCity,
            [],
          ),
        )),
      ) as _i7.Future<_i2.City>);
  @override
  _i7.Future<dynamic> setLastSelectedCity(_i2.City? city) =>
      (super.noSuchMethod(
        Invocation.method(
          #setLastSelectedCity,
          [city],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);
}

/// A class which mocks [RemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteDataSource extends _i1.Mock implements _i9.RemoteDataSource {
  @override
  _i7.Future<_i3.Result<_i10.WeatherModel>> getCurrentWeather(_i2.City? city) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentWeather,
          [city],
        ),
        returnValue: _i7.Future<_i3.Result<_i10.WeatherModel>>.value(
            _FakeResult_1<_i10.WeatherModel>(
          this,
          Invocation.method(
            #getCurrentWeather,
            [city],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Result<_i10.WeatherModel>>.value(
                _FakeResult_1<_i10.WeatherModel>(
          this,
          Invocation.method(
            #getCurrentWeather,
            [city],
          ),
        )),
      ) as _i7.Future<_i3.Result<_i10.WeatherModel>>);
}

/// A class which mocks [LocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock implements _i11.LocalDataSource {
  @override
  _i7.Future<_i3.Result<_i10.WeatherModel>> getSavedWeather(_i2.City? city) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSavedWeather,
          [city],
        ),
        returnValue: _i7.Future<_i3.Result<_i10.WeatherModel>>.value(
            _FakeResult_1<_i10.WeatherModel>(
          this,
          Invocation.method(
            #getSavedWeather,
            [city],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Result<_i10.WeatherModel>>.value(
                _FakeResult_1<_i10.WeatherModel>(
          this,
          Invocation.method(
            #getSavedWeather,
            [city],
          ),
        )),
      ) as _i7.Future<_i3.Result<_i10.WeatherModel>>);
  @override
  _i7.Future<dynamic> saveWeather(
    _i2.City? city,
    _i10.WeatherModel? weather,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWeather,
          [
            city,
            weather,
          ],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);
  @override
  _i7.Future<dynamic> setLastSelectedCity(_i2.City? city) =>
      (super.noSuchMethod(
        Invocation.method(
          #setLastSelectedCity,
          [city],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);
  @override
  _i7.Future<_i2.City> getLastSelectedCity() => (super.noSuchMethod(
        Invocation.method(
          #getLastSelectedCity,
          [],
        ),
        returnValue: _i7.Future<_i2.City>.value(_FakeCity_0(
          this,
          Invocation.method(
            #getLastSelectedCity,
            [],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i2.City>.value(_FakeCity_0(
          this,
          Invocation.method(
            #getLastSelectedCity,
            [],
          ),
        )),
      ) as _i7.Future<_i2.City>);
}

/// A class which mocks [LoadWeatherUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoadWeatherUseCase extends _i1.Mock
    implements _i12.LoadWeatherUseCase {
  @override
  _i4.WeatherRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWeatherRepository_2(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeWeatherRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.WeatherRepository);
  @override
  _i7.Stream<_i4.ResultWithState<_i8.Weather>> execute(_i2.City? city) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [city],
        ),
        returnValue: _i7.Stream<_i4.ResultWithState<_i8.Weather>>.empty(),
        returnValueForMissingStub:
            _i7.Stream<_i4.ResultWithState<_i8.Weather>>.empty(),
      ) as _i7.Stream<_i4.ResultWithState<_i8.Weather>>);
}

/// A class which mocks [GeolocatorPlatform].
///
/// See the documentation for Mockito's code generation for more information.
class MockGeolocatorPlatform extends _i1.Mock
    implements _i13.GeolocatorPlatform {
  @override
  _i7.Future<_i14.LocationPermission> checkPermission() => (super.noSuchMethod(
        Invocation.method(
          #checkPermission,
          [],
        ),
        returnValue: _i7.Future<_i14.LocationPermission>.value(
            _i14.LocationPermission.denied),
        returnValueForMissingStub: _i7.Future<_i14.LocationPermission>.value(
            _i14.LocationPermission.denied),
      ) as _i7.Future<_i14.LocationPermission>);
  @override
  _i7.Future<_i14.LocationPermission> requestPermission() =>
      (super.noSuchMethod(
        Invocation.method(
          #requestPermission,
          [],
        ),
        returnValue: _i7.Future<_i14.LocationPermission>.value(
            _i14.LocationPermission.denied),
        returnValueForMissingStub: _i7.Future<_i14.LocationPermission>.value(
            _i14.LocationPermission.denied),
      ) as _i7.Future<_i14.LocationPermission>);
  @override
  _i7.Future<bool> isLocationServiceEnabled() => (super.noSuchMethod(
        Invocation.method(
          #isLocationServiceEnabled,
          [],
        ),
        returnValue: _i7.Future<bool>.value(false),
        returnValueForMissingStub: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<_i5.Position?> getLastKnownPosition(
          {bool? forceLocationManager = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLastKnownPosition,
          [],
          {#forceLocationManager: forceLocationManager},
        ),
        returnValue: _i7.Future<_i5.Position?>.value(),
        returnValueForMissingStub: _i7.Future<_i5.Position?>.value(),
      ) as _i7.Future<_i5.Position?>);
  @override
  _i7.Future<_i5.Position> getCurrentPosition(
          {_i5.LocationSettings? locationSettings}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentPosition,
          [],
          {#locationSettings: locationSettings},
        ),
        returnValue: _i7.Future<_i5.Position>.value(_FakePosition_3(
          this,
          Invocation.method(
            #getCurrentPosition,
            [],
            {#locationSettings: locationSettings},
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.Position>.value(_FakePosition_3(
          this,
          Invocation.method(
            #getCurrentPosition,
            [],
            {#locationSettings: locationSettings},
          ),
        )),
      ) as _i7.Future<_i5.Position>);
  @override
  _i7.Stream<_i14.ServiceStatus> getServiceStatusStream() =>
      (super.noSuchMethod(
        Invocation.method(
          #getServiceStatusStream,
          [],
        ),
        returnValue: _i7.Stream<_i14.ServiceStatus>.empty(),
        returnValueForMissingStub: _i7.Stream<_i14.ServiceStatus>.empty(),
      ) as _i7.Stream<_i14.ServiceStatus>);
  @override
  _i7.Stream<_i5.Position> getPositionStream(
          {_i5.LocationSettings? locationSettings}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPositionStream,
          [],
          {#locationSettings: locationSettings},
        ),
        returnValue: _i7.Stream<_i5.Position>.empty(),
        returnValueForMissingStub: _i7.Stream<_i5.Position>.empty(),
      ) as _i7.Stream<_i5.Position>);
  @override
  _i7.Future<_i14.LocationAccuracyStatus> requestTemporaryFullAccuracy(
          {required String? purposeKey}) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestTemporaryFullAccuracy,
          [],
          {#purposeKey: purposeKey},
        ),
        returnValue: _i7.Future<_i14.LocationAccuracyStatus>.value(
            _i14.LocationAccuracyStatus.reduced),
        returnValueForMissingStub:
            _i7.Future<_i14.LocationAccuracyStatus>.value(
                _i14.LocationAccuracyStatus.reduced),
      ) as _i7.Future<_i14.LocationAccuracyStatus>);
  @override
  _i7.Future<_i14.LocationAccuracyStatus> getLocationAccuracy() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLocationAccuracy,
          [],
        ),
        returnValue: _i7.Future<_i14.LocationAccuracyStatus>.value(
            _i14.LocationAccuracyStatus.reduced),
        returnValueForMissingStub:
            _i7.Future<_i14.LocationAccuracyStatus>.value(
                _i14.LocationAccuracyStatus.reduced),
      ) as _i7.Future<_i14.LocationAccuracyStatus>);
  @override
  _i7.Future<bool> openAppSettings() => (super.noSuchMethod(
        Invocation.method(
          #openAppSettings,
          [],
        ),
        returnValue: _i7.Future<bool>.value(false),
        returnValueForMissingStub: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<bool> openLocationSettings() => (super.noSuchMethod(
        Invocation.method(
          #openLocationSettings,
          [],
        ),
        returnValue: _i7.Future<bool>.value(false),
        returnValueForMissingStub: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  double distanceBetween(
    double? startLatitude,
    double? startLongitude,
    double? endLatitude,
    double? endLongitude,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #distanceBetween,
          [
            startLatitude,
            startLongitude,
            endLatitude,
            endLongitude,
          ],
        ),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);
  @override
  double bearingBetween(
    double? startLatitude,
    double? startLongitude,
    double? endLatitude,
    double? endLongitude,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #bearingBetween,
          [
            startLatitude,
            startLongitude,
            endLatitude,
            endLongitude,
          ],
        ),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);
}

/// A class which mocks [SaveSelectedCityUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveSelectedCityUseCase extends _i1.Mock
    implements _i15.SaveSelectedCityUseCase {
  @override
  _i4.WeatherRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWeatherRepository_2(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeWeatherRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.WeatherRepository);
  @override
  _i7.Future<dynamic> execute(_i2.City? city) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [city],
        ),
        returnValue: _i7.Future<dynamic>.value(),
        returnValueForMissingStub: _i7.Future<dynamic>.value(),
      ) as _i7.Future<dynamic>);
}

/// A class which mocks [LoadSelectedCityUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoadSelectedCityUseCase extends _i1.Mock
    implements _i16.LoadSelectedCityUseCase {
  @override
  _i4.WeatherRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWeatherRepository_2(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeWeatherRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.WeatherRepository);
  @override
  _i7.Future<_i2.City> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i7.Future<_i2.City>.value(_FakeCity_0(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i2.City>.value(_FakeCity_0(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i7.Future<_i2.City>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i6.Client {
  @override
  _i7.Future<_i6.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i6.Response>);
  @override
  _i7.Future<_i6.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i6.Response>);
  @override
  _i7.Future<_i6.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i6.Response>);
  @override
  _i7.Future<_i6.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i6.Response>);
  @override
  _i7.Future<_i6.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i6.Response>);
  @override
  _i7.Future<_i6.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i6.Response>);
  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(''),
        returnValueForMissingStub: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<_i18.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i18.Uint8List>.value(_i18.Uint8List(0)),
        returnValueForMissingStub:
            _i7.Future<_i18.Uint8List>.value(_i18.Uint8List(0)),
      ) as _i7.Future<_i18.Uint8List>);
  @override
  _i7.Future<_i6.StreamedResponse> send(_i6.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i6.StreamedResponse>.value(_FakeStreamedResponse_5(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i6.StreamedResponse>.value(_FakeStreamedResponse_5(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i6.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
