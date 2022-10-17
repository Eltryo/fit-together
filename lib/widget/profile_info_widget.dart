import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String username;
  final String email;

  const ProfileInfoWidget(
      {required this.username, required this.email, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

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
        Container(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                "Upgrade to PRO",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ))
      ],
    );
  }
}
