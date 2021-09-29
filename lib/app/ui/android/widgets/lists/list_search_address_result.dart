import 'package:bikes_user/app/ui/android/widgets/cards/address_book_card.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/search_address_result_card.dart';
import 'package:flutter/material.dart';

/// A list of search address result
class ListSearchAddressResult extends StatelessWidget {
  final List<dynamic> listAddress;
  final double itemPadding;

  const ListSearchAddressResult({
    Key? key,
    required this.listAddress,
    required this.itemPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listAddress.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(bottom: itemPadding),
              child: SearchAddressResultCard(
                name: listAddress.elementAt(index).name,
                address: listAddress.elementAt(index).address,
              )
          );
        });
  }
}
