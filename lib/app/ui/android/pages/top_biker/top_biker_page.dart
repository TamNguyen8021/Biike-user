import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/top_biker_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_top_bikers.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/android/widgets/others/top_biker_bottom_sheet.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The top biker screen
class TopBikerPage extends StatelessWidget {
  const TopBikerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topBikerController = Get.find<TopBikerController>();
    Rx<String> currentMonth = DateTime.now().month.toString().obs;

    return FutureBuilder(
        future: topBikerController.getTopBiker(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
                    () => Scaffold(
                  appBar: CustomAppBar(
                    isVisible: true,
                    hasShape: true,
                    appBar: AppBar(),
                    hasLeading: true,
                    onPressedFunc: () {
                      Get.back();
                    },
                    title: Text(
                      CustomStrings.kBikerRank.tr,
                    ),
                    actionWidgets: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                        child: IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(CustomStrings.kBikerRank.tr,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      CustomStrings.kTopBikerInfoFirstContent.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          fontSize: 14,
                                          color: CustomColors.kDarkGray),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        CustomStrings.kTopBikerInfoSecondContent.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                            fontSize: 14,
                                            color: CustomColors.kDarkGray),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: Text(
                                          CustomStrings.kGotIt.tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: TextButton.styleFrom(
                                            backgroundColor: CustomColors.kDarkBlue,
                                            elevation: 5.0,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 10.0)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          icon: Icon(Icons.lightbulb),
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 10.0),
                            child: Row(
                              children: <Widget>[
                                // GestureDetector(
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(left: 12.0),
                                //     child: Icon(
                                //       Icons.arrow_back_ios,
                                //       color: Colors.black,
                                //       size: 20,
                                //     ),
                                //   ),
                                //   onTap: () {
                                //     int tempCurrentMonth =
                                //         int.tryParse(currentMonth.value)! - 1;
                                //     if (tempCurrentMonth >= 1) {
                                //       currentMonth.value = '$tempCurrentMonth';
                                //     }
                                //   },
                                // ),
                                Obx(() => Expanded(
                                    child: Center(
                                        child: Text(
                                          CustomStrings.kMonth.tr + currentMonth.value,
                                        )))),
                                // GestureDetector(
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(right: 8.0),
                                //     child: Icon(
                                //       Icons.arrow_forward_ios,
                                //       color: Colors.black,
                                //       size: 20,
                                //     ),
                                //   ),
                                //   onTap: () {
                                //     int tempCurrentMonth =
                                //         int.tryParse(currentMonth.value)! + 1;
                                //     if (tempCurrentMonth <= 12) {
                                //       currentMonth.value = '$tempCurrentMonth';
                                //     }
                                //   },
                                // )
                              ],
                            )),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: ListTopBikers(
                              listTopBikers: topBikerController.topBiker.value,
                              itemPadding: 8.0),
                        )
                      ],
                    ),
                  ),
                  bottomSheet: Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 22.0),
                    decoration: BoxDecoration(
                      color: CustomColors.kDarkBlue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                    ),
                    child: TopBikerBottomSheet(
                        index: 1,
                        avatarUrl: topBikerController.topBiker[0].avatarUrl,
                        name: topBikerController.topBiker[0].name,
                        point: topBikerController.topBiker[0].point
                    ),
                  ),
                )
            );
          } else {
            return Loading();
          }
        }
    );
  }
}
