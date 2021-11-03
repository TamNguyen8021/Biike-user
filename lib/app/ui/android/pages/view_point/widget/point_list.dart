import 'package:bikes_user/app/ui/android/pages/view_point/widget/point_card.dart';
import 'package:flutter/material.dart';

class PointList extends StatelessWidget {
  final List pointList;

  const PointList({Key? key, required this.pointList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: pointList.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: PointCard(time: 'time', title: 'title', point: 'point'),
          );
        });
  }
}
