import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/ban_list_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_ban.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

/// The 'block_list' screen
class BanListPage extends HookWidget {
  const BanListPage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(22.0),
            child: GetBuilder<BanListController>(
              builder: (controller) {
                if (controller.data == null) {
                  return Center(child: CircularProgressIndicator());
                }
                if(controller.data!.isEmpty){
                  return Text('chua co ai xui xeo bi unblock');
                }
                return ListBan(
                  itemPadding: 10.0,
                  data: controller.data!,
                  onTapItem: (blackListItem) {
                    controller.unBlock(blackListItem);
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
