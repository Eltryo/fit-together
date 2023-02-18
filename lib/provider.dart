import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/authentication.dart';

final authenticationStreamProvider = StreamProvider<User?>(
  (ref) => AuthenticationService().authState,
);
