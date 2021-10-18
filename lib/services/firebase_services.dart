import 'package:bikes_user/app/common/functions/snackbar.dart';
import 'package:bikes_user/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_logs/flutter_logs.dart';

class FirebaseServices {
  User? get user => firebaseAuth.currentUser;
  Future<String> get token async => await user?.getIdToken() ?? '';
  Future<bool> get isLogin async => (await token).isEmpty;
  String get uid => user?.uid ?? '';
  bool get isVerifyEmail => user?.emailVerified ?? false;
  String _verificationId = "";
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
          Biike.logger.e('The provided phone number is not valid.');
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
      Biike.logger.e('FirebaseServices - verifyOtp()', error);
      FlutterLogs.logErrorTrace(
          'Biike', 'FirebaseServices - verifyOtp()', error.toString(), Error());
      return false;
    }
  }

  Future<String> signinWithEmailAndPassword(String email, String pass) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      if ((userCredential.user?.uid ?? '').isNotEmpty) {
        return '';
      } else {
        throw (FirebaseAuthException);
      }
    } on FirebaseAuthException catch (error) {
      Biike.logger.e('FirebaseServices - signinWithEmailAndPassword()', error);
      FlutterLogs.logErrorTrace(
          'Biike',
          'FirebaseServices - signinWithEmailAndPassword()',
          error.toString(),
          Error());

      if (error.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (error.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }

      return 'lỗi ngoại lệ';
    }
  }

  Future<void> sentVerifyEmail() async {
    try {
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      Biike.logger.e('FirebaseServices - sentVerifyEmail()', error);
      FlutterLogs.logErrorTrace('Biike', 'FirebaseServices - sentVerifyEmail()',
          error.toString(), Error());

      SnackBarServices.showSnackbar(
          title: '', message: 'Vui lòng chờ trong giây lát rồi thử lại sau');
    }
  }

  Future<void> reloadUser() async {
    await user?.reload();
  }
}
