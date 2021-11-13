import 'dart:math' show cos, sqrt, asin;

import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:get/get.dart';

class CustomLocation {
  final String coordinate;
  double longitude = 0;
  double latitude = 0;

  CustomLocation({required this.coordinate}) {
    _parseLocation();
  }

  /// Get longitude and latitude of a location
  ///
  /// Author: UyenNLP
  _parseLocation() {
    double defaultLng = 106.80965;
    longitude = coordinate == ''
        ? defaultLng
        : double.parse(coordinate.split(',')[1]);

    double defaultLat = 10.84165;
    latitude = coordinate == ''
        ? defaultLat
        : double.parse(coordinate.split(',')[0]);
  }

  /// Get the duration between 2 location
  ///
  /// Author: UyenNLP
  Future<double> calculateDurationFrom(CustomLocation other) async {
    var duration = (await _getRouteData(other))['duration']['text'];

    return _getDoubleValue(duration); // min
  }

  /// Get the distance between 2 location
  ///
  /// Author: UyenNLP
  Future<double> calculateDistanceFrom(CustomLocation other) async {
    var milesConvertValue = 1.60934;

    var distanceInMiles = (await _getRouteData(other))['distance']['text'];
    var miles = _getDoubleValue(distanceInMiles);

    return miles * milesConvertValue; //km
  }

  Future<dynamic> _getRouteData(CustomLocation other) async {
    var  _tripProvider = Get.find<TripProvider>();
    var response = await _tripProvider.calculateDistanceAndDuration(departure: this, destination: other);

    if (response is bool) {
      return response;
    }

    return response.body['rows'][0]['elements'][0];
  }

  double _getDoubleValue(String s) {
    var index = s.indexOf(' ');
    var numberOnly = s.substring(0, index);

    return double.parse(numberOnly);
  }
}