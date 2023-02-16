import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/authentication.dart';

final authStreamProvider = StreamProvider<User?>(
  (ref) => AuthenticationService().authState,
);
final authServiceProvider = Provider<AuthenticationService>(
  (ref) => AuthenticationService(),
);
final firestoreServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);
