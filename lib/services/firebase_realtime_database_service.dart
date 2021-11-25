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
      {required receiverId,
      // required notiId,
      required BiikeNoti notification}) async {
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

  updateNotification({required userId, required RxList data}) {
    _database
        .child('/notification/$userId')
        .limitToLast(10)
        .onValue
        .listen((event) {

      try {
        final value = event.snapshot.value;
        List x = value.entries.map((e) => e.value).toList();
        print(x.toString());
        data.value = x;

      } catch (error) {
        CommonFunctions.catchExceptionError(error);
      }
    });
  }
}
