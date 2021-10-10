import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.addAuthenticator<dynamic>((request) async {
      // Set the header
      request.headers['Authorization'] = 'Bearer ${UrlStrings.token}';
      return request;
    });

    // Autenticator will be called 3 times if HttpStatus is HttpStatus.unauthorized
    httpClient.maxAuthRetries = 1;
  }

  /// Loads upcoming trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<List> getUpcomingTrips({required int userId}) async {
    final response =
        await get(UrlStrings.tripUrl + '$userId/upcoming?page=1&limit=10');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body['data']);
      return response.body['data'];
    }
  }

  /// Loads stations from API.
  ///
  /// Author: TamNTT
  Future<List> getStations() async {
    final response = await get(UrlStrings.stationUrl + '?page=1&limit=10');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body['data'];
    }
  }
}
