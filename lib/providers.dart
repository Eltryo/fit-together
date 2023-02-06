import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/auth.dart';

final authStreamProvider = StreamProvider<User?>(
  (ref) => AuthService().authState,
);
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(),
);
final firestoreServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);
