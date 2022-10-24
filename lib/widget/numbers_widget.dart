import 'package:flutter/material.dart';

import '../utils/user_numbers.dart';

class NumbersWidget extends StatelessWidget {
  //TODO: change to stateful widget
  final UserNumbers userNumbers;

  const NumbersWidget({required this.userNumbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(context, userNumbers.pictureCount.toString(), "Pictures"),
        buildDivider(),
        buildButton(
            context, userNumbers.followingCount.toString(), "Following"),
        buildDivider(),
        buildButton(context, userNumbers.followerCount.toString(), "Follower"),
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
