import 'package:bikes_user/app/ui/android/pages/address_book/address_book_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manage states of [AddressBookPage]
class AddressBookController extends GetxController {
  RxList<dynamic> addressBooks = [].obs;

  Future<void> getAddressBooks({required BuildContext context}) async {

  }
}