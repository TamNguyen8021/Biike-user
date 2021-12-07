import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/models/notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseRealtimeDatabaseService {
  late DatabaseReference _database;

  static FirebaseRealtimeDatabaseService init() {
    FirebaseRealtimeDatabaseService _databaseService =
        FirebaseRealtimeDatabaseService();
    _databaseService._database = FirebaseDatabase.instance.reference();

    return _databaseService;
  }

  Future sendNotification(
      {required receiverId, required BiikeNoti notification}) async {
    try {
      final ref = _database.child('/notification/$receiverId');
      final data = notification.toJson();
      await ref
          .push()
          .set(data)
          .then((value) => CommonFunctions.logBiike(error: data));
    } catch (error) {
      CommonFunctions.catchExceptionError(error);
    }
  }

  getNotifications({required userId, required RxMap data}) {
    _database
        .child('/notification/$userId')
        .limitToLast(30)
        .onValue
        .listen((event) {
      try {
        final value = event.snapshot.value;
        data.value = value;
      } catch (error) {
        CommonFunctions.catchExceptionError(error);
      }
    });
  }

  updateNotification({required userId, required hashKey}) async {
    try {
      final ref = _database.child('/notification/$userId/$hashKey');

      await ref.update({'isRead': true});
    } catch (error) {
      CommonFunctions.catchExceptionError(error);
    }
  }

  deleteAllNotification({required userId}) async {
    try {
      final ref = _database.child('/notification/$userId/');

      await ref.remove();
    } catch (error) {
      CommonFunctions.catchExceptionError(error);
    }
  }
}
