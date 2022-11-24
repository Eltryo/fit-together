import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/page/authenticate.dart';

import '../models/app_user.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser?>(context);
    debugPrint(appUser?.uid);

    if (appUser == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
