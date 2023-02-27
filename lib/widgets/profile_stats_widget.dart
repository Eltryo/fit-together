import 'package:fit_together/models/app_user_stats.dart';
import 'package:flutter/material.dart';

class ProfileStats extends StatefulWidget {
  final AppUserStats appUserStats;

  const ProfileStats({
    required this.appUserStats,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileStats> createState() => _ProfileStatsState();
}

class _ProfileStatsState extends State<ProfileStats> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton("Pictures", widget.appUserStats.pictureCount),
        buildDivider(),
        buildButton("Following", widget.appUserStats.followingCount),
        buildDivider(),
        buildButton("Follower", widget.appUserStats.followerCount),
      ],
    );
  }

  Widget buildButton(String text, int value) {
    return MaterialButton(
      //TODO: implement button function
      onPressed: () {},
      child: Column(
        children: [
          Text(value.toString()),
          const SizedBox(height: 2),
          Text(text)
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
