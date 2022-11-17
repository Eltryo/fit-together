import 'package:flutter/material.dart';

class NumbersWidget extends StatefulWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  State<NumbersWidget> createState() => _NumbersWidgetState();
}

class _NumbersWidgetState extends State<NumbersWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(context, "0", "Pictures"), //TODO replace hardcoded values
        buildDivider(),
        buildButton(context, "0", "Following"),
        buildDivider(),
        buildButton(context, "0", "Follower"),
      ],
    );
  }

  Widget buildButton(BuildContext context, String value, String text) {
    return MaterialButton(
      onPressed: () {},
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            text,
          )
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const SizedBox(
      height: 24,
      child: VerticalDivider(),
    );
  }
}
