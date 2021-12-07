import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';

class PathshareProvider extends CommonProvider {
  @override
  Future<Map<String, String>> get headers async {
    return <String, String>{
      'X-API-Token':
          '61f43e389c1d6bcf3b16b20dd3f49dac9e0c7bfe4487d28710e3502635ba6071',
      'X-User-Token': Biike.pathshareUserToken
    };
  }

  /// Register a user to start a session
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> createUser(
      {required String userName, required String userPhoneNumber}) async {
    final response = await post(
        UrlStrings.pathshareUserUrl,
        {
          "user": {
            "name": userName,
            "phone": userPhoneNumber,
          }
        },
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return {};
    } else {
      return response.body;
    }
  }

  /// Create user location to share with others
  ///
  /// Author: TamNTT
  Future<bool> createUserLocation(
      {required double userLat, required double userLng}) async {
    final response = await post(
        UrlStrings.pathshareUserUrl +
            '/${Biike.pathshareUserIdentifier}/locations',
        {
          "locations": [
            {
              "latitude": userLat,
              "longitude": userLng,
              "recorded_at": DateTime.now().toIso8601String()
            }
          ]
        },
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Create session to share location
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> createSession(
      /*{required double endLat, required double endLng}*/) async {
    final response = await post(
        UrlStrings.pathshareSessionUrl,
        {
          "session": {
            "name": "My Location",
            "expires_at":
                DateTime.now().subtract(Duration(hours: 6)).toIso8601String()
            // "destination": {
            //   "name": "Destination",
            //   "latitude": endLat,
            //   "longitude": endLng
            // }
          }
        },
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return {};
    } else {
      return response.body;
    }
  }

  /// Start or stop sharing your location
  ///
  /// Author: TamNTT
  Future<bool> startOrStopLocationSharing(
      {required bool isShared, required String sessionIdentifier}) async {
    final response = await patch(
        UrlStrings.pathshareSessionUrl + '/$sessionIdentifier/participation',
        {
          "participation": {"sharing": isShared}
        },
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Start or stop sharing your location
  ///
  /// Author: TamNTT
  Future<bool> leaveSession({required String sessionIdentifier}) async {
    final response = await delete(
        UrlStrings.pathshareSessionUrl + '/$sessionIdentifier/participation',
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}
