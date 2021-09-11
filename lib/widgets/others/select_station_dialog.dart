import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/others/station_dropdown_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectStationDialog extends StatelessWidget {
  String? _value;
  final String title;
  final selectedStation;

  SelectStationDialog(
      {Key? key,
        required this.title,
        required this.selectedStation})
      : super(key: key);

  //TODO get list from database
  final List<String> _dropdownToArray = [
    'Cổng khu công nghệ cao',
    'Two',
    'Free',
    'Four'
  ];

  List<String> _getStationList() {
    List<String> result = [];
    for(var s in _dropdownToArray) {
      if (s != selectedStation) {
        result.add(s);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    _value = _getStationList().first;

    return AlertDialog(
      title: Text(title),
      content: StationDropdownButton(
        dropdownValue: _getStationList().first,
        dropdownArray: _getStationList(),
        onChangedFunc: (value) =>
            _value = value,
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel')),
        ElevatedButton(
            onPressed: () => Navigator.pop(context, _value),
            child: Text('confirm')),
      ],
    );
  }
}