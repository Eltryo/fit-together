import 'package:flutter/material.dart';

import '../models/user.dart';
import '../widget/numbers_widget.dart';
import '../widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userPreferences = User.empty().getPreferences();
  var userNumbers = User.empty().getUserNumbers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          ProfileWidget(
            imagePath: _checkImagePath(userPreferences.imagePath),
            onClicked: () async {},
          ),
          const SizedBox(height: 10),
          Text(
            userPreferences.username,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            userPreferences.email,
            style: const TextStyle(
                fontStyle: FontStyle.italic, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          NumbersWidget(
            userNumbers: userNumbers,
          ),
        ],
      ),
    );
  }

  String _checkImagePath(String? imagePath) {
    if (imagePath == null) {
      return "lib/images/default_user_image.png";
    }
    return imagePath;
  }
}
