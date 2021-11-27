import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/ui/android/pages/ban_list/ban_list_page.dart';
import 'package:bikes_user/app/ui/android/pages/ban_list/model/black_list_response.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/network/repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// Manage states of [BanListPage]
class BanListController extends GetxController {
  static BanListController get to => Get.find<BanListController>();

  final repositories = getIt<Repositories>();
  List<BlackListItem> data = [];

  Future<void> getBlackList({required BuildContext context}) async {
    try {
      data.clear();
      final BlackListResponse result =
          await repositories.getBlackList(Biike.userId.value, 1, 10);
      data = result.data;
      data.removeWhere((element) => element.isBlock == false);
    } catch (e) {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
    } finally {
      update();
    }
  }

  Future<void> unBlock(
      {required BuildContext context,
      required BlackListItem blackListItem}) async {
    try {
      update();
      blackListItem.isBlock = false;

      await repositories.unBlock(blackListItem: blackListItem);
    } catch (e) {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
    } finally {
      getBlackList(context: context);
      update();
    }
  }
}
