import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseServices {
  String _verificationId = '';
  late FirebaseAuth firebaseAuth;

  static FirebaseServices init() {
    FirebaseServices firebaseServices = FirebaseServices();
    firebaseServices.firebaseAuth = FirebaseAuth.instance;
    return firebaseServices;
  }

  Future<void> sendCode(
      {required String fullPhone, required Function() codeSented}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullPhone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          CommonFunctions.logBiike(
              error: 'The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        codeSented();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      final authCredential = await firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .catchError((error) {
        CommonFunctions.catchExceptionError(error);
      });
      if (authCredential.user != null) {
        // success
        return true;
      }
      return false;
    } catch (error) {
      CommonFunctions.catchExceptionError(error);
      return false;
    }
  }

  Future<bool> resetPasswordWithEmail(
      {required BuildContext context, required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                headerAnimationLoop: false,
                desc: CustomErrorsString.kInvalidEmail.tr)
            .show();
        return false;
      }
      if (e.code == 'user-not-found') {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                headerAnimationLoop: false,
                desc: CustomErrorsString.kWrongEmailOrPassword.tr)
            .show();
        return false;
      }
      return false;
    }
  }
}
