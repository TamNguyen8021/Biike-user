import 'package:bikes_user/app/common/functions/CustomTrace/custom_trace.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';

class CommonProvider extends GetConnect {
  /// Return header to attach to api request
  ///
  /// Author: UyenNLP
  Future<Map<String, String>> get headers async {
    ///chon cai final token: lay token moi, tu dong lay token moi khi het han, test co van de thi report
   
    // String token = Biike.token.value; <-- old
    final token = await getIt<FirebaseServices>().user?.getIdToken(); //this <---- new ( author: vantl)
    return <String, String>{'Authorization': 'Bearer $token'};
  }

  /// Log api response
  ///
  /// Author: UyenNLP
  void logResponse(Response response) {
    CustomTrace info = CustomTrace(StackTrace.current);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike ${info.callerFunctionName}(): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);
  }

  /// Log api response
  ///
  /// Author: UyenNLP
  void logError(Response response) {
    CustomTrace info = CustomTrace(StackTrace.current);

    Biike.logger.e(
        '${info.callerFunctionName}()',
        response.statusCode.toString() +
            ' ' +
            response.statusText! +
            '\n' +
            response.body);
  }
}
