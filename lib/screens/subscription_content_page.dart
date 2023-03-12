import 'package:flutter/material.dart';

class SubscriptionContentPage extends StatelessWidget {
  const SubscriptionContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: change hardcode values
    return Scaffold(
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        //TODO: show subscription content
      ),
    );
  }
}
