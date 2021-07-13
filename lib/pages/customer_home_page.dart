import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/app_bar.dart';
import 'package:bikes_user/widgets/bottom_navigation.dart';
import 'package:bikes_user/widgets/list_trips.dart';
import 'package:bikes_user/widgets/trip_card.dart';
import 'package:flutter/material.dart';

/// The state of the customer home page widget
class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

/// The customer home page widget
class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: <Widget>[
                Text(CustomStrings.appName),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 20,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          CustomStrings.customerMode,
                          style:
                              TextStyle(color: CustomColors.blue, fontSize: 12),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.lightGray),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionWidgets: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                CustomStrings.readyReminder,
                                style: TextStyle(
                                    color: CustomColors.darkGray, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '15' + CustomStrings.reminderTime,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: CustomColors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        TripCard(
                            backgroundColor: CustomColors.blue,
                            foregroundColor: Colors.white,
                            iconColor: Colors.white,
                            avatarUrl: 'assets/images/test_avatar.jpg',
                            name: 'Phát Đỗ',
                            time: '06:45',
                            date: CustomStrings.today,
                            sourceStation: 'Đại học FPT TP.HCM',
                            destinationStation: 'Chung cư SKY9'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: () => {},
                                  icon: Icon(Icons.check),
                                  label: Text(
                                    CustomStrings.finishTrip,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              CustomColors.blue)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: CustomColors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: CustomColors.darkGray
                                            .withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 0.5,
                                        // changes position of shadow
                                        offset: Offset(0, 1),
                                      )
                                    ]),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.phone),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: CustomColors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: CustomColors.darkGray
                                            .withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 0.5,
                                        // changes position of shadow
                                        offset: Offset(0, 1),
                                      )
                                    ]),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.message),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 150,
                            color: CustomColors.blue,
                            child: Image(
                              image: AssetImage('assets/images/demo_ads.jpg'),
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          CustomStrings.today,
                          style: TextStyle(
                              color: CustomColors.darkGray, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        TripCard(
                            backgroundColor: CustomColors.lightGray,
                            foregroundColor: CustomColors.darkGray,
                            iconColor: CustomColors.blue,
                            avatarUrl: 'assets/images/test_avatar.jpg',
                            name: 'Phát Đỗ',
                            time: '06:45',
                            date: CustomStrings.today,
                            sourceStation: 'Đại học FPT TP.HCM',
                            destinationStation: 'Chung cư SKY9'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          CustomStrings.otherDays,
                          style: TextStyle(
                              color: CustomColors.darkGray, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: ListTrips(list: [1, 2, 3, 4, 5])),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: CustomColors.orange,
          elevation: 0.0,
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}
