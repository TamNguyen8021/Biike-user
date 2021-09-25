import 'package:bikes_user/widgets/cards/top_biker_card.dart';
import 'package:flutter/material.dart';

/// A list of top bikers
class ListTopBikers extends StatelessWidget {
  final List listTopBikers;
  final double itemPadding;

  const ListTopBikers(
      {Key? key, required this.listTopBikers, required this.itemPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listTopBikers.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: EdgeInsets.only(bottom: itemPadding),
            child: TopBikerCard(
                index: i,
                avatarUrl: 'assets/images/profile-4.jpg',
                name: 'Nguyễn Lê Thảo Phương',
                point: 5678),
          );
        });
  }
}
