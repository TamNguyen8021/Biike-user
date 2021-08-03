import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/lists/list_upcoming_trips.dart';
import 'package:flutter/material.dart';

/// The activity page widget
class Activity extends StatelessWidget {
  final String role;
  const Activity({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _roleActivity;
    if (role == 'Customer') {
      _roleActivity = CustomStrings.kCustomerActivity;
    } else {
      _roleActivity = CustomStrings.kDriverActivity;
    }

    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _roleActivity,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.kBlue),
                      ),
                      IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/history'),
                          icon: Icon(
                            Icons.history,
                            color: CustomColors.kBlue,
                          ))
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  CustomStrings.kToday,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: ListUpcomingTrips(
                  listUpcomingTrips: [1, 2],
                  itemPadding: 10.0,
                  isTodayFirstActivity: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(CustomStrings.kTomorrow,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: ListUpcomingTrips(
                  listUpcomingTrips: [1, 2],
                  itemPadding: 10.0,
                  isTodayFirstActivity: false,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
