import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

/// This widget contains a customer trip's details
class CustomerCard extends StatelessWidget {
  final String avatarUrl;

  const CustomerCard({Key? key, required this.avatarUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: CustomColors.kDarkGray.withOpacity(0.05),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CircleAvatar(
                radius: 40, backgroundImage: AssetImage(avatarUrl)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Yến Linh',
              style: TextStyle(
                  color: CustomColors.kBlue, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
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
            child: Text.rich(TextSpan(children: <InlineSpan>[
              TextSpan(
                  text: '4.5',
                  style: TextStyle(fontSize: 10, color: Colors.white)),
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: CustomColors.kLightGray))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.event_outlined,
                                ),
                              ),
                              Text(
                                CustomStrings.kToday,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: CustomColors.kDarkGray.withOpacity(0.15),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.access_time,
                                ),
                              ),
                              Text('06:35',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.adjust,
                                ),
                                Icon(
                                  Icons.more_vert_outlined,
                                ),
                                Icon(
                                  Icons.location_on,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Đại học FPT TP.HCM',
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text('Chung cư SKY9',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 30.0),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.kLightGray),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Text(
                            CustomStrings.kDecline,
                            style: TextStyle(
                                color: CustomColors.kDarkGray,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 30.0),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Text(
                            CustomStrings.kAccept,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
