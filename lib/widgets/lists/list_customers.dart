import 'package:bikes_user/widgets/cards/customer_card.dart';
import 'package:flutter/material.dart';

/// A list of customers' trips
class ListCustomers extends StatelessWidget {
  final List listCustomers;

  const ListCustomers({Key? key, required this.listCustomers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listCustomers.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: CustomerCard(
                avatarUrl: 'assets/images/profile-2.jpg',
              ));
        });
  }
}
