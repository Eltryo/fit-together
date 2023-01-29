import 'package:flutter/material.dart';

class SubscriptionContentPage extends StatefulWidget {
  const SubscriptionContentPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionContentPage> createState() =>
      _SubscriptionContentPageState();
}

class _SubscriptionContentPageState extends State<SubscriptionContentPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: change hardcode value
    return GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: List<Container>.filled(
        10,
        growable: true,
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/prison_mike.jpg"),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
