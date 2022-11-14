import 'package:flutter/material.dart';
import 'package:sports_app/page/routes/edit_profile.dart';
import 'package:sports_app/page/routes/route_builder.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileImageWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildEditIcon(context, color),
          )
        ],
      ),
    );
  }

  Widget buildImage() {
    return CircleAvatar(
      backgroundImage: AssetImage(imagePath),
      radius: 50,
    );
  }

  Widget buildEditIcon(BuildContext context, Color color) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          RouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const EditProfile())),
      child: buildCircle(
          color: Colors.white,
          all: 3,
          child: buildCircle(
              color: color,
              all: 8,
              child: const Icon(
                Icons.edit,
                size: 15,
                color: Colors.white,
              ))),
    );
  }

  Widget buildCircle({
    required Color color,
    required double all,
    required Widget child,
  }) {
    return ClipOval(
      child: Container(
        color: color,
        padding: EdgeInsets.all(all),
        child: child,
      ),
    );
  }
}
