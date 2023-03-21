import 'package:flutter/material.dart';

class SubscriptionContentPage extends StatelessWidget {
  const SubscriptionContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: change hardcode values
    return const Scaffold(
      body: Center(
        child: Text(
          "Subscription Content",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      //TODO: show subscription content
    );
  }
}
