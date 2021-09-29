import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget contains an search address result's details
class SearchAddressResultCard extends StatelessWidget {
  final String name;
  final String address;

  const SearchAddressResultCard(
      {Key? key,
        required this.name,
        required this.address,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(CommonRoutes.ADD_ADDRESS_BOOK),
      child: Container(
        height: 72,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                    address,
                    style: TextStyle(
                        fontSize: 10.0
                    )
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CustomColors.kLightGray,
              width: 1.5
            )
          )
        ),
      ),
    );
  }
}
