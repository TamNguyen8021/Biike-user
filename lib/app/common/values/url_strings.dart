class UrlStrings {
  static const String _baseUrl =
      'https://biike-api.azurewebsites.net/api/biike/v1/';
  static const String tripUrl = _baseUrl + 'trips/';
  static const String userUrl = _baseUrl + 'users/';
  static const String stationUrl = _baseUrl + 'stations';
  static const String voucherUrl = _baseUrl + 'vouchers';
  static const String voucherCategoryUrl = _baseUrl + 'voucherCategories';
  static const String redemptionUrl = _baseUrl + 'redemptions';
  static const String walletUrl = _baseUrl + 'wallets/';
  static const String bikeUrl = _baseUrl + 'bikes/';
  static const String imageUrl = _baseUrl + 'images';

  static const String googleMapApiKey =
      'AIzaSyATchI6wf0LyaEBcSB9xZz86iYuPm9Je-k';
  static const String _googleMapUrl = 'https://maps.googleapis.com/maps/api/';
  static const String distancematrixUrl = _googleMapUrl + 'distancematrix/json';
  static const String placeDetailsUrl = _googleMapUrl + 'place/details/json';

  static const String _pathshareBaseUrl =
      'https://pathsha.re/api/professional/v1/';
  static const String pathshareSessionUrl = _pathshareBaseUrl + 'sessions';
  static const String pathshareUserUrl = _pathshareBaseUrl + 'users';
  static const String directionUrl = _googleMapUrl + 'directions/json';
}
