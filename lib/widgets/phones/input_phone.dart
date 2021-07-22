
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputPhoneNumber {
  String? countryISOCode;
  String? countryCode;
  String? number;

  InputPhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  String get completeNumber {
    return countryCode! + number!;
  }
}