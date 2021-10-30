import 'package:bikes_user/app/data/models/feedback.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FeedbackProvider extends GetConnect {
  static const url = "https://localhost:44342/api/biike/v1";

  Future<bool> sendFeedback(Feedback feedback) async {
    final response = await post("https://biike-api.azurewebsites.net/api/biike/v1/Feedbacks", feedback.toJson());
    if (response.statusCode != 200) {
      // return Future.error(response.statusText!);
      return false;
    }
    // return response.body;
    return true;
  }

  Future<List<Feedback>> getFeedback() async {
    final response = await get("https://biike-api.azurewebsites.net/api/biike/v1/Feedbacks/1");
    if (response.statusCode == 200) {
      // return Future.error(response.statusText!);
    }
    return response.body;
  }
}