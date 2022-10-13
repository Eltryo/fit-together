import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List<Container>.filled(
          10,
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/images/prison_mike.jpg")),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          growable: true),
    );
  }
}
