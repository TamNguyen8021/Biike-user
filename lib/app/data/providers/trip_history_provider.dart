import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class TripHistoryProvider extends GetConnect {
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

  /// Loads history trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<List> getHistoryTrips({required int userId}) async {
    final response =
        await get(UrlStrings.tripUrl + '$userId/history?page=1&limit=10');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body['data'];
    }
  }
}
