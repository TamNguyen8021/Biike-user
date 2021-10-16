import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/controllers/trip_history_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_history_trips.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The trip history screen
class TripHistoryPage extends StatelessWidget {
  const TripHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tripHistoryController = Get.find<TripHistoryController>();

    return FutureBuilder(
        future: _tripHistoryController.getHistoryTrips(
            context: context, userId: Biike.userId, role: 1),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: CustomAppBar(
                isVisible: true,
                hasShape: false,
                appBar: AppBar(),
                hasLeading: true,
                title: Text(
                  CustomStrings.kHistory.tr,
                ),
                bottomAppBar: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: CustomColors.kDarkGray.withOpacity(0.3),
                            blurRadius: 5,
                            // changes position of shadow
                            offset: Offset(0, 4),
                          )
                        ]),
                    child: TabBar(
                      unselectedLabelColor: CustomColors.kDarkGray,
                      unselectedLabelStyle:
                          TextStyle(fontWeight: FontWeight.bold),
                      labelColor: CustomColors.kBlue,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      indicator: BoxDecoration(
                          color: CustomColors.kLightGray,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      indicatorPadding: const EdgeInsets.all(10.0),
                      tabs: <Widget>[
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              CustomStrings.kKeerHistory.tr,
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              CustomStrings.kBikerHistory.tr,
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                      onTap: (int index) async {
                        switch (index) {
                          case 0:
                            await _tripHistoryController.getHistoryTrips(
                                context: context,
                                userId: Biike.userId,
                                role: 1);
                            break;
                          case 1:
                            await _tripHistoryController.getHistoryTrips(
                                context: context,
                                userId: Biike.userId,
                                role: 2);
                            break;
                          default:
                        }
                      },
                    ),
                  ),
                ),
              ),
              body: snapshot.connectionState == ConnectionState.done
                  ? SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.all(22.0),
                            child: TabBarView(children: <Widget>[
                              Obx(
                                () => ListHistoryTrips(
                                    role: Role.keer,
                                    listHistoryTrips: _tripHistoryController
                                        .historyTrips
                                        .toList(),
                                    itemPadding: 16.0),
                              ),
                              Obx(
                                () => ListHistoryTrips(
                                    role: Role.biker,
                                    listHistoryTrips: _tripHistoryController
                                        .historyTrips
                                        .toList(),
                                    itemPadding: 16.0),
                              ),
                            ]),
                          )
                        ],
                      ),
                    )
                  : Loading(),
            ),
          );
        });
  }
}
