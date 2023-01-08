import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'authenticate.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final user = ref.watch(authStreamProvider);

      return user.when(
          data: (data) {
            if (data != null) {
              debugPrint("user is logged in");
              return const Home();
            } else {
              debugPrint("user is logged out");
              return const Authenticate();
            }
          },
          error: (error, _) => Text("Error: $error"),
          loading: () => const CircularProgressIndicator());
    });
  }
}
