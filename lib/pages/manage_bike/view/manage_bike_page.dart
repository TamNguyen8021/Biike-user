import 'package:bikes_user/pages/manage_bike/controller/manage_bike_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 'manage_bike' screen
class ManageBikePage extends StatelessWidget {
  final bool isBikeVerified;

  ManageBikePage({Key? key, required this.isBikeVerified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manageBikeController = Get.find<ManageBikeController>();

    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          isVisible: true,
          hasLeading: true,
          hasShape: true,
          appBar: AppBar(),
          title: Text(
            CustomStrings.kManageBike,
          ),
          actionWidgets: <Widget>[
            if (manageBikeController.hasBike.isTrue) ...[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () => manageBikeController.removeBike(),
                  icon: Icon(Icons.delete),
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () => Get.toNamed('/addBike'),
                  icon: Icon(Icons.add),
                ),
              ),
            ]
          ],
        ),
        body: manageBikeController.hasBike.isTrue
            ? Container(
                margin: const EdgeInsets.all(22.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    color: CustomColors.kLightGray,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: CustomColors.kDarkGray.withOpacity(0.3),
                        // changes position of shadow
                        offset: Offset(0, 1.5),
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.two_wheeler,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '75A - 456.15',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        if (isBikeVerified) ...[
                          Text(
                            CustomStrings.kBikeVerified,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: CustomColors.kBlue),
                          ),
                        ] else ...[
                          Text(
                            CustomStrings.kWaitingVerified,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: CustomColors.kOrange),
                          ),
                        ]
                      ]),
                    ),
                    Divider(
                        // color: CustomColors.kRed,
                        ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            CustomStrings.kBikeOwner,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Đỗ Hữu Phát',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Text(
                            CustomStrings.kBikeBrand,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Yamaha',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Text(
                            CustomStrings.kBikeCategory,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Tay ga',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Text(
                            CustomStrings.kBikeColor,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            'Tím',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 30.0),
                child: Text(
                  CustomStrings.kSuggestAddBike,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.kDarkGray,
                  ),
                ),
              ),
      ),
    );
  }
}
