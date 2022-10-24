import 'package:flutter/material.dart';

import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return either home or Authenticate widget
    return const Home();
  }
}
