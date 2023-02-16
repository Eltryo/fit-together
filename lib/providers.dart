import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:fit_together/services/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/authentication.dart';

final authenticationStreamProvider = StreamProvider<User?>(
  (ref) => AuthenticationService().authState,
);
final authenticationServiceProvider = Provider<AuthenticationService>(
  (ref) => AuthenticationService(),
);
final firestoreServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);
final storageServiceProvider = Provider<StorageService>(
      (ref) => StorageService(),
);
