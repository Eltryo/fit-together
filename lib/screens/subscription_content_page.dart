import 'package:flutter/material.dart';

class SubscriptionContentPage extends StatelessWidget {
  const SubscriptionContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: change hardcode values
    return GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: List.filled(
        10,
        growable: true,
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/prison_mike.jpg"),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}
