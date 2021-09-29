import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/search_address_result_card.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_search_address_result.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The sos number screen
class SearchAddressPage extends StatelessWidget {
  const SearchAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        appBar: AppBar(),
        hasLeading: true,
        title: Text(
          CustomStrings.kSearchAddress.tr,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      counter: Offstage(),
                      hintText: CustomStrings.kEnterAddress.tr,
                      hintStyle: TextStyle(
                        color: CustomColors.kDarkGray.withOpacity(0.3),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.white, width: 0.0),
                        borderRadius: BorderRadius.all(
                            const Radius.circular(5.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.white, width: 0.0),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      filled: true,
                      fillColor: CustomColors.kLightGray,
                    ),
                    onChanged: (feedback) {

                    },
                  ),
              ),
              ListSearchAddressResult(
                listAddress: [
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  SearchAddressResultCard(
                      name: 'Chung cư SKY9',
                      address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                ],
                itemPadding: 0.0,
              ),
            ],
          )
        ),
      )
    );
  }
}
