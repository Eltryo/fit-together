import 'package:flutter/material.dart';
import 'package:fit_together/screens/edit_profile_page.dart';
import 'package:fit_together/widgets/route_builder.dart';

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
          buildImage(),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildEditIcon(context, Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }

  Widget buildImage() {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage(imagePath),
      radius: 50,
    );
  }

  Widget buildEditIcon(BuildContext context, Color color) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        RouteBuilder(widget: const EditProfilePage()).buildRoute(),
      ),
      child: buildCircle(
        color: Colors.white,
        paddingOffset: 3,
        child: buildCircle(
          color: color,
          paddingOffset: 8,
          child: const Icon(
            Icons.edit,
            size: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildCircle({
    required Color color,
    required double paddingOffset,
    required Widget child,
  }) {
    return ClipOval(
      child: Container(
        color: color,
        padding: EdgeInsets.all(paddingOffset),
        child: child,
      ),
    );
  }
}
