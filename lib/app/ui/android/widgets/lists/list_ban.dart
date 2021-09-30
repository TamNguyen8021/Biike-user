import 'package:bikes_user/app/ui/android/widgets/cards/ban_list_card.dart';
import 'package:flutter/material.dart';

/// A list of ban
class ListBan extends StatelessWidget {
  final List<dynamic> banList;
  final double itemPadding;

  const ListBan({
    Key? key,
    required this.banList,
    required this.itemPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: banList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(bottom: itemPadding),
              child: BanListCard(
                name: banList.elementAt(index).name,
              )
          );
        });
  }
}
