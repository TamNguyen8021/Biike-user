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
  static const String pointUrl = _baseUrl + 'pointHistory';
  static const String intimaciesUrl = _baseUrl + 'intimacies';
  static const String reportUrl = _baseUrl + 'reports';
  static const String feedbackUrl = _baseUrl + 'feedbacks';
  static const String sos = _baseUrl + 'Sos';

  static const String googleMapApiKey =
      'AIzaSyATchI6wf0LyaEBcSB9xZz86iYuPm9Je-k';
  static const String _googleMapUrl = 'https://maps.googleapis.com/maps/api/';
  static const String distancematrixUrl = _googleMapUrl + 'distancematrix/json';
  static const String placeDetailsUrl = _googleMapUrl + 'place/details/json';
  static const String directionUrl = _googleMapUrl + 'directions/json';

  static const String apiMomoPayment = 'https://test-payment.momo.vn/pay/app';
  static const String configurationUrl = _baseUrl + 'Configurations';
  static const String momoTransactionUrl = _baseUrl + 'MomoTransactions';

  static const String _pathshareBaseUrl =
      'https://pathsha.re/api/professional/v1/';
  static const String pathshareSessionUrl = _pathshareBaseUrl + 'sessions';
  static const String pathshareUserUrl = _pathshareBaseUrl + 'users';
}
