import 'package:bikes_user/app/ui/android/pages/ban_list/ban_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manage states of [BanListPage]
class BanListController extends GetxController {
  RxList<dynamic> banList = [].obs;

  Future<void> getBanList({required BuildContext context}) async {

  }
}