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
    longitude =
        coordinate == '' ? defaultLng : double.parse(coordinate.split(',')[1]);

    double defaultLat = 10.84165;
    latitude =
        coordinate == '' ? defaultLat : double.parse(coordinate.split(',')[0]);
  }
}
