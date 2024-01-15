import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/presentation/home/app_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authentication_wrapper.dart';

class EntryWrapper extends StatelessWidget {
  const EntryWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return user != null
        ? const AppTabController()
        : const AuthenticationWrapper();
  }
}
