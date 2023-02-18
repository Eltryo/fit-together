import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:fit_together/services/storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;

setup() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => StorageService());
}
