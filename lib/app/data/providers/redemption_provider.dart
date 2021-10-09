import 'package:bikes_user/app/common/functions/common_provider.dart';

class RedemptionProvider extends CommonProvider {
  Future<bool> exchangeVoucher(data) async {
    final response = await post('https://biike-api.azurewebsites.net/api/biike/v1/redemptions', data);

    return response.statusCode == 200
        ? Future.value(true)
        : Future.value(false);
  }

  Future<dynamic> getYourVoucherList({userId}) async {
    var url = CommonProvider.API_URL + '/redemptions/users/$userId/full?page=1&limit=2';
    //TODO
    final response = await
      get(url, headers: await getHeaders());

    if (response.statusCode == 200) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }
}