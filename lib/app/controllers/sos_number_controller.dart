import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/models/sos.dart';
import 'package:bikes_user/app/data/providers/sos_number_provider.dart';
import 'package:bikes_user/app/ui/android/pages/sos_number/sos_number_page.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/sos_number_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manage states of [SOSNumberPage]
class SOSNumberController extends GetxController {
  final _sosProvider = Get.find<SOSNumberProvider>();

  RxList<dynamic> sosNumbers = [].obs;

  Future<void> getSOSNumbers() async {
    sosNumbers.clear();

    dynamic response = await _sosProvider.getSOSNumbers();

    if (response != null) {
      try {
        for (var sosNumber in response) {
          SOS sos = SOS.fromJson(sosNumber);

          sosNumbers.add(
            SOSNumberCard(
                id: sos.sosId!,
                name: sos.sosName!,
                number: sos.sosPhone!
            )
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> removeSOSNumber({required BuildContext context, required int id}) async {
    bool result = await _sosProvider.removeSOSNumber(id: id);
    if (result) {
      await getSOSNumbers();
      Get.back();
      CommonFunctions().showInfoDialog(
          context: context,
          message: "Xoá số SOS thành công!");
    } else {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
    }
  }
}