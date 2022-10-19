import 'package:flutter/material.dart';
import 'package:sports_app/utils/user_preferences.dart';
import 'package:sports_app/widget/profile_info_widget.dart';

import '../widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 40,
          ),
          ProfileWidget(
            imagePath: checkImagePath(user.imagePath),
            onClicked: () async{},
          ),
          const SizedBox(
            height: 10
          ),
          ProfileInfoWidget(
            username: user.username,
            email: user.email,
            pictureCount: user.pictureCount,
            followingCount: user.followerCount,
            followerCount: user.followerCount
          ),
        ],
      ),
    );
  }

  String checkImagePath(String? imagePath) { //TODO: Add _ as private identifier
    if(imagePath == null){
      return "lib/images/default_user_image.png";
    }
    return imagePath;
  }
}
