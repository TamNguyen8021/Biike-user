import 'package:bikes_user/app/ui/android/pages/notification/widget/notificaiton_card.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {
  final List notiList;

  const NotificationList({Key? key, required this.notiList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: notiList.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: NotificationCard(
                title: 'Accepted',
                content: 'csmakmalscmalkmclakmcamclamclkmalcsmakcmlakcmslmclamcklamcklamcklamlmcaslmcsa',
                date: DateTime.now()),
          );
        });
  }
}
