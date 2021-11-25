import 'package:bikes_user/app/ui/android/pages/ban_list/model/black_list_response.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/ban_list_card.dart';
import 'package:flutter/material.dart';

/// A list of ban
class ListBan extends StatelessWidget {
  final List<BlackListItem> data;
  final double itemPadding;
  final Function(BlackListItem) onTapItem;
  const ListBan({
    Key? key,
    required this.data,
    required this.itemPadding,
    required this.onTapItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Text('chua co ai xui xeo bi block');
    } else {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.only(bottom: itemPadding),
                child: BanListCard(
                  name: data[index].userName,
                  onTapUnBlock: () {
                    onTapItem(data[index]);
                  },
                ));
          });
    }
  }
}
