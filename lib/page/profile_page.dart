import 'package:flutter/material.dart';

import '../widget/numbers_widget.dart';
import '../widget/profile_image_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          ProfileImageWidget(
            imagePath: _checkImagePath("lib/images/prison_mike.jpg"),
            //TODO replace hardcoded values
            onClicked: () async {},
          ),
          const SizedBox(height: 10),
          const Text(
            "Prison_Mike",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "prison.mike@gmail.com",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          const NumbersWidget(),
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
