import 'package:bikes_user/utils/enums.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';

/// The home screen template for both ke-er and biker
class AddBikePage extends StatelessWidget {
  final Role role;
  const AddBikePage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String modeButtonText = CustomStrings.kCustomerMode;
    String addBikeText = 'Thêm xe mới';
    // String settingButton = 'Cài đặt';
    // String rateAppButton = 'Đánh giá ứng dụng';
    // String logOutButton = 'Đăng xuất';
    // String bikeNumberPlate = '75A - 456.15';
    String bikeOwner = 'Tên chủ xe';
    // String bikeOwerValue = 'Đỗ Hữu Phát';
    String bikeCategory = 'Loại xe';
    // String bikeCategoryValue = 'Tay ga';
    String bikeBrand = 'Hiệu xe';
    // String bikeBrandValue = 'Yamaha';
    String bikeColor = 'Màu xe';
    // String bikeColorValue = 'Tím';
    // Color modeButtonForegroundColor = CustomColors.kBlue;
    // Color modeButtonBackgroundColor = CustomColors.kLightGray;

    // List<String> listBikeCategory = [
    //   "Đại học FPT TP.HCM",
    //   'Two',
    //   'Free',
    //   'Four'
    // ];
    // List<String> listBikeBrand = [
    //   "Cổng khu công nghệ cao",
    //   'Two',
    //   'Free',
    //   'Four'
    // ];
    // List<String> listBikeColor = [
    //   "Cổng khu công nghệ cao",
    //   'Two',
    //   'Free',
    //   'Four'
    // ];

    // String valueChoose = '0';
    // List listItem = ['1', '2', '3'];

    int _value = 1;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          isVisible: true,
          appBar: AppBar(),
          hasShape: true,
          hasLeading: true,
          title: Text(
            addBikeText,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(bikeOwner),
                  TextField(
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Nhập họ tên'),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(bikeCategory),
                  DropdownButton(
                      value: _value, items: [], hint: Text("Chọn loại xe")),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(bikeBrand),
                  DropdownButton(
                      value: _value, items: [], hint: Text("Chọn hiệu xe")),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(bikeColor),
                  DropdownButton(
                      value: _value, items: [], hint: Text("Chọn màu xe")),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text('Biển số xe'),
                  TextField(
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Nhập biển số xe'),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
