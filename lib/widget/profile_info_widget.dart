import 'package:flutter/material.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

import 'numbers_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  //TODO: change to stateful widget
  final String username;
  final String email;

  int pictureCount;
  int followingCount;
  int followerCount;

  ProfileInfoWidget({
    required this.username,
    required this.email,
    required this.pictureCount,
    required this.followingCount,
    required this.followerCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme
        .of(context)
        .primaryColor;

    return Column(
      children: [
        Text(
          username,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          email,
          style:
          const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        RoundedButtonWidget(color: color, text: "Upgrade to PRO"),
        const SizedBox(height: 20),
        NumbersWidget(
          pictureCount: pictureCount,
          followingCount: followingCount,
          followerCount: followerCount,
        )
      ],
    );
  }
}
