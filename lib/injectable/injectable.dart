import 'package:bikes_user/services/firebase_realtime_database_service.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:bikes_user/services/shared_preference_service.dart';
import 'package:bikes_user/services/token_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies() async => $initGetIt(getIt);

@module
abstract class Services {
  @singleton
  FirebaseServices get firebaseServices => FirebaseServices.init();

  @singleton
  TokenService get tokenService => TokenService.init();

  @singleton
  FirebaseRealtimeDatabaseService get realtimeDatabaseService =>
      FirebaseRealtimeDatabaseService.init();

  @preResolve
  Future<AppPref> get appPref => AppPref.instance();
}
