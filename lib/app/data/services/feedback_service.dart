import 'package:bikes_user/app/data/models/feedback.dart';
import 'package:http/http.dart' as http;

class FeedbackService {
  static var client = http.Client();

  static Future<http.Response> sendFeedback(Feedback feedback) async {
    var res = await client.post(Uri.parse('https://localhost:44342/api/biike/v1/Feedbacks'), body: feedback.toJson());
    if (res.statusCode == 200) {
      return res;
    } else {
      return res;
    }
  }
}