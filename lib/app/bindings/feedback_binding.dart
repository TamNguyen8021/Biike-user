import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/feedbacks_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/providers/feedback_provider.dart';
import 'package:bikes_user/app/data/providers/wallet_provider.dart';
import 'package:get/get.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(FeedbackController());
    CommonFunctions.bind(WalletController());
    CommonFunctions.bind(FeedbackProvider());
    CommonFunctions.bind(WalletProvider());
  }
}
