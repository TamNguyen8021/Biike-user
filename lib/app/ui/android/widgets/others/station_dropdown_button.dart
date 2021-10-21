import 'package:bikes_user/app/data/models/station.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class StationDropdownButton extends StatelessWidget {
  final Station dropdownValue;
  final List<Station> dropdownArray;
  final Function(Station?) onChangedFunc;

  const StationDropdownButton(
      {Key? key,
        required this.dropdownValue,
        required this.dropdownArray,
        required this.onChangedFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomColors.kDarkGray.withOpacity(0.3),
              // changes position of shadow
              offset: Offset(0, 1),
            )
          ],
          color: CustomColors.kLightGray,
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonFormField<Station>(
        value: dropdownValue,
        icon: Icon(
          Icons.arrow_drop_down,
          color: CustomColors.kDarkGray,
        ),
        onChanged: onChangedFunc,
        items: dropdownArray.map<DropdownMenuItem<Station>>((Station value) {
          return DropdownMenuItem<Station>(
            value: value,
            child: Text(
              value.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        }).toList(),
        decoration: InputDecoration(
            fillColor: CustomColors.kLightGray,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
