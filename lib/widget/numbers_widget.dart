import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget { //TODO: change to stateful widget
  int pictureCount;
  int followingCount;
  int followerCount;

  NumbersWidget({
    required this.pictureCount,
    required this.followingCount,
    required this.followerCount,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(context, pictureCount.toString(), "Pictures"),
        buildButton(context, followingCount.toString(), "Following"),
        buildButton(context, followerCount.toString(), "Follower"),
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
}
