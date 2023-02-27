import 'package:fit_together/screens/edit_profile_page.dart';
import 'package:fit_together/widgets/route_builder.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileImage({
    required this.imagePath,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(imagePath),
            radius: 50,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                RouteBuilder(widget: const EditProfilePage()).buildRoute(),
              ),
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(3),
                  child: ClipOval(
                    child: Container(
                      color: Colors.teal,
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
