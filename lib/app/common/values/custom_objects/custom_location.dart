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
}
