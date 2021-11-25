import 'package:flutter/material.dart';

/// A list of address books
class ListAddressBooks extends StatelessWidget {
  final List<dynamic> listAddressBooks;
  final double itemPadding;

  const ListAddressBooks({
    Key? key,
    required this.listAddressBooks,
    required this.itemPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listAddressBooks.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(bottom: itemPadding),
              child: listAddressBooks.elementAt(index));
        });
  }
}
