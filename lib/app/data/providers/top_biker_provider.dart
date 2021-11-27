import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class TopBikerProvider extends CommonProvider {
  Future<dynamic> getTopBiker() async {
    final response = await get(UrlStrings.userUrl + 'topBiker', headers: await headers);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }

    return Future.error(response.statusText!);
  }
}
