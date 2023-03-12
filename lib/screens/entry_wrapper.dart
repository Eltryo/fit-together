import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_tab_controller.dart';
import 'authentication_wrapper.dart';

class EntryWrapper extends StatelessWidget {
  const EntryWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return user != null
        ? const HomeTabController()
        : const AuthenticationWrapper();
  }
}
