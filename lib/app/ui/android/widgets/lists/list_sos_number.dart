import 'package:bikes_user/app/ui/android/widgets/cards/sos_number_card.dart';
import 'package:flutter/material.dart';

/// A list of sos numbers
class ListSOSNumbers extends StatelessWidget {
  final List<dynamic> listSOSNumbers;
  final double itemPadding;

  const ListSOSNumbers({
    Key? key,
    required this.listSOSNumbers,
    required this.itemPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listSOSNumbers.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(bottom: itemPadding),
              child: SOSNumberCard(
                name: listSOSNumbers.elementAt(index).name,
                number: listSOSNumbers.elementAt(index).number,
              )
          );
        });
  }
}
