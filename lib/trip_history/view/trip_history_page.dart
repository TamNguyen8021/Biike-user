import 'package:bikes_user/trip_history/controller/trip_history_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/lists/list_history_trips.dart';
import 'package:bikes_user/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The trip history screen
class TripHistoryPage extends StatelessWidget {
  const TripHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tripHistoryController = Get.find<TripHistoryController>();

    return FutureBuilder(
        future: tripHistoryController.getHistoryTrips(context: context),
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
                  CustomStrings.kHistory,
                ),
                bottomAppBar: PreferredSize(
                  preferredSize: new Size.fromHeight(0),
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
                      tabs: const <Widget>[
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              CustomStrings.kCustomerHistory,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              CustomStrings.kDriverHistory,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                      onTap: (int index) {
                        switch (index) {
                          case 0:
                            tripHistoryController.role.value = Role.Customer;
                            tripHistoryController.getHistoryTrips(
                                context: context);
                            break;
                          case 1:
                            tripHistoryController.role.value = Role.Driver;
                            tripHistoryController.getHistoryTrips(
                                context: context);
                            break;
                          default:
                        }
                      },
                    ),
                  ),
                ),
              ),
              body: tripHistoryController.historyTrips.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.all(22.0),
                            child: TabBarView(children: <Widget>[
                              Obx(
                                () => ListHistoryTrips(
                                    role: tripHistoryController.role.value,
                                    listHistoryTrips: tripHistoryController
                                        .historyTrips
                                        .toList(),
                                    itemPadding: 16.0),
                              ),
                              Obx(
                                () => ListHistoryTrips(
                                    role: tripHistoryController.role.value,
                                    listHistoryTrips: tripHistoryController
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
