import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/ban_list_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_ban.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

/// The 'block_list' screen
class BanListPage extends HookWidget {
  final _banListController = Get.find<BanListController>();

  BanListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        appBar: AppBar(),
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        title: Text(
          CustomStrings.kBanList.tr,
        ),
      ),
      body: FutureBuilder(
          future: _banListController.getBlackList(context: context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: ListBan(
                  itemPadding: 10.0,
                  data: _banListController.data,
                  onTapItem: (blackListItem) async {
                    await _banListController.unBlock(
                        context: context, blackListItem: blackListItem);
                  },
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
