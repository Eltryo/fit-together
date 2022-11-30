import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_app/page/authenticate.dart';

import '../models/app_user.dart';
import '../services/provider.dart';
import 'home.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppUser? appUser = ref.watch(CustomProvider.authServiceProvider
        as ProviderListenable<AppUser?>); //TODO find better solution

    if (appUser == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
