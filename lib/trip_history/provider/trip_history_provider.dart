import 'package:get/get.dart';

class TripHistoryProvider extends GetConnect {
  Future<Response> getAvatar(String name) async {
    final response = await get(
        'https://ui-avatars.com/api/?name=$name&background=random&rounded=true&size=128');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
