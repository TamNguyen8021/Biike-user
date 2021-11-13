import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';

class AddressBookProvider extends CommonProvider {
  Future<bool> addAddressBook({required Map<String, dynamic> body}) async {
    final response =
    await post(UrlStrings.userUrl + "addresses", body, headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> editAddressBook({required Map<String, dynamic> body, required int id}) async {
    final response = await put(UrlStrings.userUrl + "addresses" + '/${id}', body, headers: await headers);
    print(body);
    print(response.body);
    logResponse(response);
    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> removeAddressBook({ required int id }) async {
    final response = await delete(UrlStrings.userUrl + "addresses" + '/${id}',
        headers: await headers);

    logResponse(response);

    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}
