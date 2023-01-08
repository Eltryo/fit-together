import 'package:flutter/material.dart';

class ProfileStats extends StatefulWidget {
  const ProfileStats({Key? key}) : super(key: key);

  @override
  State<ProfileStats> createState() => _ProfileStatsState();
}

class _ProfileStatsState extends State<ProfileStats> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //TODO replace hardcoded values and add interactivity
        buildButton(context, "0", "Pictures"),
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
