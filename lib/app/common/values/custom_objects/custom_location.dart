import 'dart:math' show cos, sqrt, asin;

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

  /// Get the distance between 2 location
  ///
  /// Author: UyenNLP
  double distanceFrom(CustomLocation other) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((other.latitude - this.latitude) * p)/2 +
        cos(this.latitude * p) * cos(other.latitude * p) *
            (1 - cos((other.longitude - this.longitude) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}