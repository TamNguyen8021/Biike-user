import 'package:bikes_user/app/data/providers/top_up_point_provider.dart';
import 'package:get/get.dart';

class TopUpPointController extends GetxController {
  final _topUpPointProvider = Get.find<TopUpPointProvider>();

  Future<void> createPayment({required Map<String, dynamic> body}) async {
    dynamic response = _topUpPointProvider.paymentWithMomo(body: body);
  }
}
