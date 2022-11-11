import 'package:flutter/material.dart';
import 'package:sports_app/page/routes/edit_profile.dart';

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
      onTap: () => Navigator.push(context, _createRoute()),
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

  Route _createRoute() {
    const Duration duration = Duration(milliseconds: 100);
    return PageRouteBuilder(
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const EditProfile(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const Offset begin = Offset(1.0, 0.0);
          const Offset end = Offset.zero;
          const curve = Curves.easeOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        }); // Offset begin = Offset.zero;
    // Offset end = const Offset(1.0, 0.0);
  }
}
