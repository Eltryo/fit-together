import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../widgets/home_tab_controller.dart';
import 'authentication_wrapper.dart';

class EntryWrapper extends ConsumerWidget {
  const EntryWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStreamProvider).when(
          data: (user) {
            if (user != null) {
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
  }
}
