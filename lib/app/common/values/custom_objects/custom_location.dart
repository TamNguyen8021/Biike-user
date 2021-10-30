import 'dart:math' show cos, sqrt, asin;

class CustomLocation {
  final String coordinate;

  CustomLocation({required this.coordinate});

  /// Get longitude of a location
  ///
  /// Author: UyenNLP
  double get longitude {
    double defaultLng = 106.80965;

    return coordinate == ''
        ? defaultLng
        : double.parse(coordinate.split(',')[1]);
  }

  /// Get latitude of a location
  ///
  /// Author: UyenNLP
  double get latitude {
    double defaultLat = 10.84165;

    return coordinate == ''
        ? defaultLat
        : double.parse(coordinate.split(',')[0]);
  }

  /// Get the distance between 2 location
  ///
  /// Author: UyenNLP
  double distanceFrom(CustomLocation other) {
    var startLat = this.latitude;
    var startLng = this.longitude;
    var endLat = other.latitude;
    var endLng = other.longitude;

    var p = 0.017453292519943295;
    var a = 0.5 - cos((endLat - startLat) * p)/2 +
        cos(startLat * p) * cos(endLat * p) *
            (1 - cos((endLng - startLng) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}