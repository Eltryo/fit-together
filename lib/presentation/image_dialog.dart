import 'package:fit_together/presentation/post_comments.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/application/authentication.dart';
import 'package:fit_together/application/firestore.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  final FileImage image;

  const ImageDialog({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  late FirestoreService _firestoreService;
  late AuthenticationService _authService;

  Animation<Matrix4>? animation;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        debugPrint("listening on animation");
        _transformationController.value = animation!.value;
      });
    _firestoreService = locator<FirestoreService>();
    _authService = locator<AuthenticationService>();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _buildImage(),
          _buildDialogBar(),
        ],
      ),
    );
  }

  Widget _buildDialogBar() => Container(
        color: Colors.black.withOpacity(0.5),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                //TODO: Add like functionality
                _toggle();
              },
              icon: Icon(
                _liked ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostComments(),
                  ),
                );
              },
              icon: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  Widget _buildImage() => InteractiveViewer(
        transformationController: _transformationController,
        onInteractionEnd: (details) {
          debugPrint("end interaction");
          resetAnimation();
        },
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  void _toggle() {
    setState(
      () {
        _liked = !_liked;
      },
    );
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.ease),
    );
    debugPrint("forward animation");
    _animationController.forward(from: 0);
  }
}
