import 'package:flutter/material.dart';
import 'package:sports_app/screens/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    //return either Home or Authenticate widget
    return const Authenticate();
  }
}
