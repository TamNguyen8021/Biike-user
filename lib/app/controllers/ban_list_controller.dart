
import 'package:bikes_user/app/common/functions/snackbar.dart';
import 'package:bikes_user/app/ui/android/pages/ban_list/ban_list_page.dart';
import 'package:bikes_user/app/ui/android/pages/ban_list/model/black_list_response.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/network/repositories.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:get/get.dart';

/// Manage states of [BanListPage]
class BanListController extends GetxController {
  static BanListController get to => Get.find<BanListController>();

  final repositories = getIt<Repositories>();
  final FirebaseServices firebaseServices = getIt<FirebaseServices>();
  List<BlackListItem>? data;

  void getBlackList() async {
    try {
      final BlackListResponse result =
          await repositories.getBlackList(firebaseServices.uid, 1, 10000);
      data = result.data;
      data?.removeWhere((element) => element.isBlock == false);
    } catch (e) {
      SnackBarServices.showSnackbar(
          title: 'bike', message: 'đã có lỗi xảy ra vui lòng thử lại sau');
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    getBlackList();
    super.onInit();
  }

  unBlock(BlackListItem blackListItem) async {
    try {
      data = null;

      update();
      blackListItem.isBlock = false;

      await repositories.unBlock(blackListItem: blackListItem);
    } catch (e) {
      SnackBarServices.showSnackbar(
          title: 'bike', message: 'đã có lỗi xảy ra vui lòng thử lại sau');
    } finally {
      getBlackList();
      update();
    }
  }
}
