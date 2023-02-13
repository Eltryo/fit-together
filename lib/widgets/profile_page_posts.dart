import 'package:flutter/material.dart';

class ProfilePagePosts extends StatefulWidget {
  const ProfilePagePosts({Key? key}) : super(key: key);

  @override
  State<ProfilePagePosts> createState() => _ProfilePagePostsState();
}

class _ProfilePagePostsState extends State<ProfilePagePosts> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: List<Container>.filled(
        10,
        growable: true,
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/prison_mike.jpg"),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
