import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'authentication_wrapper.dart';
import '../widgets/home_tab_controller.dart';

class EntryWrapper extends StatelessWidget {
  const EntryWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final user = ref.watch(authStreamProvider);
        return user.when(
          data: (data) {
            if (data != null) {
              debugPrint("user is logged in");
              return const HomeTabController();
            } else {
              debugPrint("user is logged out");
              return const AuthenticationWrapper();
            }
          },
          error: (error, _) => Text("Error: $error"),
          loading: () => const CircularProgressIndicator(),
        );
      },
    );
  }
}
