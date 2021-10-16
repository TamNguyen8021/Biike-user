import 'package:bikes_user/app/common/functions/common_provider.dart';

class BikeProvider extends CommonProvider {
  Future<dynamic> getBike(userId) async {
    final response = await
    get('$apiUrl/Bikes/users/$userId', headers: await getHeaders());

    if (response.statusCode == 200) {
      return response.body['data'];
    }

    return Future.error(response.statusText!);
  }

  Future<bool> addBike(data) async {
    final response = await
    post('$apiUrl/Bikes', data, headers: await getHeaders());

    return response.statusCode == 200
        ? Future.value(true)
        : Future.value(false);
  }

  Future<bool> removeBike(userId) async {
    final response = await
    delete('$apiUrl/Bikes/$userId', headers: await getHeaders());

    print('$apiUrl/Bikes/$userId');
    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200
        ? Future.value(true)
        : Future.value(false);
  }
}