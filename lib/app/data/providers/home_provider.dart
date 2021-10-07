import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = UrlStrings.baseUrl;

    // It's will attach 'token' property on header from all requests
    // httpClient.addRequestModifier<dynamic>((request) {
    //   request.headers['id_token'] =
    //       'eyJhbGciOiJSUzI1NiIsImtpZCI6IjM1MDM0MmIwMjU1MDAyYWI3NWUwNTM0YzU4MmVjYzY2Y2YwZTE3ZDIiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoixJBpbmggUGhhbiBI4bqjaSBUcmnhu4F1IiwicGljdHVyZSI6Imh0dHBzOi8vdWktYXZhdGFycy5jb20vYXBpLz9uYW1lPUhhaStUcmlldSZiYWNrZ3JvdW5kPXJhbmRvbSZyb3VuZGVkPXRydWUmc2l6ZT0xMjgiLCJyb2xlIjoxLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYmlpa2UtYzZhNzAiLCJhdWQiOiJiaWlrZS1jNmE3MCIsImF1dGhfdGltZSI6MTYzMzU3NzkzMSwidXNlcl9pZCI6IjEiLCJzdWIiOiIxIiwiaWF0IjoxNjMzNTc3OTMxLCJleHAiOjE2MzM1ODE1MzEsImVtYWlsIjoiaGFpdHJpZXUueWFyZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlciI6Iis4NDk4MzMzNTAwMCIsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsicGhvbmUiOlsiKzg0OTgzMzM1MDAwIl0sImVtYWlsIjpbImhhaXRyaWV1LnlhcmVAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.q0_jAn3u1e_RR4Cp1aQFdPlQSDODAmRdCNZ5hcq2PDaOFo9LAjc0zUJUkFY9R0MQWB38N7FUOKjm8NvFpm-UKkQCiuOHtuBp5JNe55cHzUH2GNhsgV9uju9kqM_aPWqYE9mSQp1m0LCd-645hYwGxm3Bi4b5tVIgrgnkmKVRBngoHbPY6gJCe2rUMD3CsVXYVbElTxVZ8-_LG93w5ns-V1kAd1k5QemH62G1a7SztHKi1lJEq-1CdUGS_q4y92KMkzrTQ8PyEiQeBrXSAaAHlrnsPe4HlsTLPUGMMAkjG50_QcCj-MLTW5BwXG6nTIVFbdm-o_kTOIQfmv7gnbaxjA';
    //   print(request.headers);
    //   return request;
    // });

    httpClient.addAuthenticator<dynamic>((request) async {
      print('addAuthenticator');
      final response = await httpClient.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCCMLMl1CZBpHU0P97gYFUtpNp2y5wN1RU');
      final token = response.body['idToken'];
      print(token);
      // Set the header
      request.headers['Authorization'] = 'Bearer $token';
      return request;
    });

    // Autenticator will be called 3 times if HttpStatus is HttpStatus.unauthorized
    httpClient.maxAuthRetries = 1;
  }

  /// Loads upcoming trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<List> getUpcomingTrips(
      {required int userId, required int role}) async {
    final response = await httpClient.get(httpClient.baseUrl! +
        UrlStrings.tripUrl +
        '$userId/upcoming?role=$role&page=1&limit=10');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body['data'];
    }
  }

  /// Loads stations from API.
  ///
  /// Author: TamNTT
  Future<List> getStations({required int page}) async {
    final response =
        await httpClient.get(UrlStrings.stationUrl + '?$page=$page&limit=10');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body['data'];
    }
  }
}
