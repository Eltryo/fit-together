import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/page/create_email.dart';

import 'auth.dart';

class CustomProvider {
  static final authServiceProvider =
      StreamProvider((ref) => AuthService().user);
  static final emailProvider = Provider((ref) => CreateEmailState().email);
}
