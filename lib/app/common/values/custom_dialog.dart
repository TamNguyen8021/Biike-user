import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  final BuildContext context;
  late AwesomeDialog loadingDialog;

  CustomDialog({required this.context}) {
    _createLoadingDialog();
  }

  void _createLoadingDialog() {
    loadingDialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      body: SizedBox(height: 150, child: Loading()),
    );
  }
}
