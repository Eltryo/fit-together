import 'package:flutter/material.dart';
import 'package:sports_app/utils/user_preferences.dart';

import '../widget/numbers_widget.dart';
import '../widget/profile_widget.dart';
import '../widget/rounded_button_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    final color = Theme
        .of(context)
        .primaryColor;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          ProfileWidget(
            imagePath: _checkImagePath(user.imagePath),
            onClicked: () async{},
          ),
          const SizedBox(
            height: 10
          ),
          Text(
            user.username,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email,
            style:
            const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          RoundedButtonWidget(color: color, text: "Upgrade to PRO"),
          const SizedBox(height: 20),
          NumbersWidget(
            pictureCount: user.pictureCount,
            followingCount: user.followingCount,
            followerCount: user.followerCount,
          )
        ],
      ),
    );
  }

  String _checkImagePath(String? imagePath) {
    if(imagePath == null){
      return "lib/images/default_user_image.png";
    }
    return imagePath;
  }
}
