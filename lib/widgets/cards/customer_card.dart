import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

/// This widget contains a customer trip's details
class CustomerCard extends StatelessWidget {
  const CustomerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.kDarkGray.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/test_avatar.jpg')),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
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
                              right: BorderSide(
                                  color: CustomColors.kDarkGray
                                      .withOpacity(0.15)))),
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
                                    color: CustomColors.kBlue,
                                    size: 15,
                                  ),
                                ),
                                Text(
                                  CustomStrings.kToday,
                                  style: TextStyle(
                                      color: CustomColors.kDarkGray,
                                      fontSize: 12),
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
                                    color: CustomColors.kBlue,
                                    size: 15,
                                  ),
                                ),
                                Text('06:35',
                                    style: TextStyle(
                                        color: CustomColors.kDarkGray,
                                        fontSize: 12)),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              Text('Đại học FPT TP.HCM',
                                  style: TextStyle(
                                      color: CustomColors.kDarkGray,
                                      fontSize: 12)),
                            ],
                          ),
                          Icon(
                            Icons.more_vert_outlined,
                            color: CustomColors.kBlue,
                            size: 15,
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
                              Text('Chung cư SKY9',
                                  style: TextStyle(
                                      color: CustomColors.kDarkGray,
                                      fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
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
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                CustomColors.kBlue),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10.0),
                            child: Text(
                              CustomStrings.kAccept,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
