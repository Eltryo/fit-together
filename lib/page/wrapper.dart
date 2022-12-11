import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/main.dart';
import 'package:sports_app/page/authenticate.dart';
import 'package:sports_app/page/route_builder.dart';

import 'home.dart';

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  ConsumerState<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      final appUser = ref.watch(MyApp.authServiceProvider);
      debugPrint("The app user is $appUser");

      appUser.when(
          data: (user) => user != null
              ? Navigator.of(context).pushReplacement(RouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Home()))
              : Navigator.of(context).pushReplacement(RouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Authenticate())),
          error: (error, _) => Text("Error: $error"),
          loading: () => const CircularProgressIndicator());
    });

    return const SizedBox.shrink();
  }
}
