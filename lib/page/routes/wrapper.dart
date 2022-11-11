import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/models/app_user.dart';
import 'package:sports_app/page/authenticate.dart';

import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    debugPrint(user?.uid);

    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
