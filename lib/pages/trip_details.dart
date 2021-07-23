import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/contact_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TripDetails extends StatelessWidget {
  final String role;
  const TripDetails({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationBar = CustomAppBar(
      appBar: AppBar(),
      leadingWidget: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text(CustomStrings.kTripDetails),
    );

    final informationBar = Container(
      decoration: BoxDecoration(
          color: CustomColors.kDarkGray.withOpacity(0.05),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Đã tạo"),
            Text("05:07, 08 Tháng 3, 2021"),
          ],
        ),
      ),
    );

    final mapsViewer = Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Image.network(
          "https://images.unsplash.com/photo-1523443571261-671bddef4ecd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1665&q=80"),
    );

    final tripInformation = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: CustomColors.kLightGray,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: CustomColors.kDarkGray.withOpacity(0.4),
                        // changes position of shadow
                        offset: Offset(0, 1),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.event_outlined,
                              color: CustomColors.kBlue,
                              size: 15,
                            ),
                          ),
                          Text(
                            CustomStrings.kToday,
                            style: TextStyle(
                                color: CustomColors.kDarkGray, fontSize: 12),
                          ),
                        ],
                      ),
                      Divider(
                        color: CustomColors.kDarkGray.withOpacity(0.3),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.access_time,
                              color: CustomColors.kBlue,
                              size: 15,
                            ),
                          ),
                          Text(
                            CustomStrings.kSelectHour,
                            style: TextStyle(
                                color: CustomColors.kDarkGray, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.kLightGray,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomColors.kDarkGray.withOpacity(0.4),
                      // changes position of shadow
                      offset: Offset(0, 1),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.adjust,
                            color: CustomColors.kBlue,
                            size: 15,
                          ),
                        ),
                        Text(
                          CustomStrings.kSelectSourceStation,
                          style: TextStyle(
                              color: CustomColors.kDarkGray, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.more_vert_outlined,
                          color: CustomColors.kBlue,
                          size: 15,
                        ),
                        Expanded(
                          child: Divider(
                            color: CustomColors.kDarkGray.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.location_on,
                            color: CustomColors.kBlue,
                            size: 15,
                          ),
                        ),
                        Text(
                          CustomStrings.kSelectDestinationStation,
                          style: TextStyle(
                              color: CustomColors.kDarkGray, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        )
      ],
    );

    final waitingForTrip = Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
              color: CustomColors.kDarkGray.withOpacity(0.05),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/loading-big.svg',
                  height: 75.0,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  CustomStrings.kTripStatus,
                  style: TextStyle(
                      color: CustomColors.kBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ));

    final driverInformation = Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
              color: CustomColors.kDarkGray.withOpacity(0.05),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/test_avatar.jpg'),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text(
                        'Yến Linh',
                        style: TextStyle(
                            color: CustomColors.kBlue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: CustomColors.kOrange,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: CustomColors.kDarkGray.withOpacity(0.3),
                              // changes position of shadow
                              offset: Offset(0, 1.5),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        child: Text.rich(TextSpan(children: <InlineSpan>[
                          TextSpan(
                              text: '4.5',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                          WidgetSpan(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                          )),
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Icon(
                              Icons.star_rate_rounded,
                              size: 11,
                              color: Colors.white,
                            ),
                          ))
                        ])),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      ContactButtons(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));

    final cancelButton = Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Container(
          width: 140,
          decoration: BoxDecoration(
              color: CustomColors.kDarkGray.withOpacity(0.05),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.clear),
                SizedBox(
                  width: 10,
                ),
                Text(CustomStrings.kCancelTrip),
              ],
            ),
          ),
        ));

    final confirmArrivalButton = Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Container(
          width: 165,
          decoration: BoxDecoration(
              color: CustomColors.kBlue,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Row(
              children: [
                Icon(
                  Icons.done_all_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  CustomStrings.kConfirmArrival,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ));

    return Scaffold(
      appBar: navigationBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Column(
            children: [
              informationBar,
              mapsViewer,
              tripInformation,
              waitingForTrip,
              // driverInformation,
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton,
                    // confirmArrivalButton,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
