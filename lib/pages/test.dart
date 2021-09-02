import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookTrip extends StatefulWidget {
  const BookTrip({Key? key}) : super(key: key);

  @override
  _BookTripState createState() => _BookTripState();
}

class _BookTripState extends State<BookTrip> {
  String dropdownFromValue = "Đại học FPT TP.HCM";
  String dropdownToValue = "Cổng khu công nghệ cao";
  String kBookNewTrip = "Test";
  List<String> dropdownFromArray = [
    "Đại học FPT TP.HCM",
    'Two',
    'Free',
    'Four'
  ];
  List<String> dropdownToArray = [
    "Cổng khu công nghệ cao",
    'Two',
    'Free',
    'Four'
  ];

  @override
  Widget build(BuildContext context) {
    final navigationBar = CustomAppBar(
      isVisible: true,
      hasLeading: true,
      hasShape: true,
      appBar: AppBar(),
      title: Text(CustomStrings.kBookNewTrip),
    );

    final mapsViewer = Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Image.network(
          "https://images.unsplash.com/photo-1523443571261-671bddef4ecd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1665&q=80"),
    );

    final informationBar = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "23 phút",
            style: TextStyle(color: CustomColors.kBlue, fontSize: 18),
          ),
          Text("15.8km"),
        ],
      ),
    );

    return Scaffold(
      appBar: navigationBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Từ"),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.kLightGray,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomColors.kDarkGray.withOpacity(0.4),
                      // changes position of shadow
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: dropdownFromValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownFromValue = newValue!;
                          });
                        },
                        items: dropdownFromArray
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Đến"),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.kLightGray,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomColors.kDarkGray.withOpacity(0.4),
                      // changes position of shadow
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: dropdownToValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownToValue = newValue!;
                          });
                        },
                        items: dropdownToArray
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ),
                ),
              ),
              mapsViewer,
              informationBar,
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 170,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColors.kOrange),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {},
                      child: Text('Đặt lịch ké'),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 170,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColors.kBlue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {},
                      child: Text('Ké now'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
