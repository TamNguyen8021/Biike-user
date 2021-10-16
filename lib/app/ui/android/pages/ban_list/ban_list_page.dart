import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/ban_list_card.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_ban.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'block_list' screen
class BanListPage extends StatelessWidget {
  const BanListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final banListController = Get.find<BanListController>();

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        appBar: AppBar(),
        hasLeading: true,
        title: Text(
          CustomStrings.kBanList.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(22.0),
              child: ListBan(
                banList: [
                  BanListCard(name: 'Võ Thị Kim Thuỳ'),
                  BanListCard(name: 'Võ Thị Kim Thuỳ'),
                  BanListCard(name: 'Võ Thị Kim Thuỳ'),
                ],
                itemPadding: 10.0,
              )),
        ]),
      ),
    );
  }
}
