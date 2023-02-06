import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/auth.dart';

final authStreamProvider = StreamProvider<User?>(
  (ref) => AuthService().authState,
);