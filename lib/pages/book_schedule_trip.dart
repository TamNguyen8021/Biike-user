import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/buttons/date_button.dart';
import 'package:bikes_user/widgets/buttons/time_button.dart';
import 'package:flutter/material.dart';

class BookScheduleTrip extends StatefulWidget {
  const BookScheduleTrip({Key? key}) : super(key: key);

  @override
  _BookScheduleTripState createState() => _BookScheduleTripState();
}

class _BookScheduleTripState extends State<BookScheduleTrip> {
  DateTime selectedDate = DateTime.now();
  DateTime repeatedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isDateSelected = false;
  bool isRepeatedDateSelected = false;
  bool isTimeSelected = false;
  bool isRepeated = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      isDateSelected = true;
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectRepeatingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          repeatedDate.isBefore(selectedDate) ? selectedDate : repeatedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      isRepeatedDateSelected = true;
      setState(() {
        repeatedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      isTimeSelected = true;
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationBar = CustomAppBar(
      appBar: AppBar(),
      leadingWidget: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text(CustomStrings.kBookScheduleTrip),
    );

    return Scaffold(
      appBar: navigationBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Thời gian",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.kLightGray,
                    ),
                    child: Container(
                      width: 125,
                      child: Text(
                        isDateSelected
                            ? "${selectedDate.toLocal()}".split(' ')[0]
                            : "Chọn ngày",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.kLightGray,
                    ),
                    child: Container(
                      width: 125,
                      child: Text(
                        isTimeSelected
                            ? "${selectedTime.format(context)}"
                            : "Chọn giờ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeButton(time: "06:30"),
                  TimeButton(time: "07:15"),
                  TimeButton(time: "10:00"),
                  TimeButton(time: "12:00"),
                  TimeButton(time: "13:45"),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lặp lại",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: isRepeated,
                    onChanged: (bool value) {
                      setState(() {
                        isRepeated = value;
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: isRepeated,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DateButton(date: "T2"),
                        DateButton(date: "T3"),
                        DateButton(date: "T4"),
                        DateButton(date: "T5"),
                        DateButton(date: "T6"),
                        DateButton(date: "T7"),
                        DateButton(date: "CN"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Lặp lại đến",
                      style: TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectRepeatingDate(context),
                      style: ElevatedButton.styleFrom(
                        primary: CustomColors.kLightGray,
                      ),
                      child: Container(
                        width: 125,
                        child: Text(
                          isRepeatedDateSelected
                              ? "${repeatedDate.toLocal()}".split(' ')[0]
                              : "Chọn ngày",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isRepeated ? 40 : 160,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: CustomColors.kOrange,
                    padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                  ),
                  child: Text(
                    "Đặt lịch ké",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
