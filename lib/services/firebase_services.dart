import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirebaseServices {
  User? get user => firebaseAuth.currentUser;
  Future<String> get token async => await user?.getIdToken() ?? '';
  Future<bool> get isLogin async => (await token).isEmpty;
  String get uid => user?.uid ?? '';
  bool get isVerifyEmail => user?.emailVerified ?? false;
  String _verificationId = '';
  late FirebaseAuth firebaseAuth;

  static FirebaseServices init() {
    FirebaseServices firebaseServices = FirebaseServices();
    firebaseServices.firebaseAuth = FirebaseAuth.instance;
    return firebaseServices;
  }

  Future<void> sendCode(
      {required String fullPhone, required Function callBackSentCode}) async {
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
        callBackSentCode();
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
      final authCredential =
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
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

  // Future<String> signinWithEmailAndPassword(String email, String pass) async {
  //   try {
  //     UserCredential userCredential = await firebaseAuth
  //         .signInWithEmailAndPassword(email: email, password: pass);
  //     if ((userCredential.user?.uid ?? '').isNotEmpty) {
  //       return '';
  //     } else {
  //       throw (FirebaseAuthException);
  //     }
  //   } on FirebaseAuthException catch (error) {
  //     CommonFunctions.catchExceptionError(error);

  //     if (error.code == 'user-not-found' || error.code == 'wrong-password') {
  //       return CustomErrorsString.kWrongEmailOrPassword.tr;
  //     }
  //     return CustomErrorsString.kDevelopError.tr;
  //   }
  // }

  Future<void> sentVerifyEmail({required BuildContext context}) async {
    try {
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      CommonFunctions.catchExceptionError(error);
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
    }
  }

  Future<void> reloadUser() async {
    await user?.reload();
  }

  Future<bool> resetPasswordWithEmail(
      {required BuildContext context, required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        CommonFunctions().showErrorDialog(
            context: context, message: CustomErrorsString.kInvalidEmail.tr);
        return false;
      }
      if (e.code == 'user-not-found') {
        CommonFunctions().showErrorDialog(
            context: context, message: CustomErrorsString.kWrongEmail.tr);
        return false;
      }
      return false;
    }
  }
}
