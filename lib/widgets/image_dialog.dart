import 'dart:typed_data';

import 'package:fit_together/screens/post_comments.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  final Uint8List imageData;

  const ImageDialog({required this.imageData, Key? key}) : super(key: key);

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  final firestoreService = locator<FirestoreService>();
  final authenticationService = locator<AuthenticationService>();

  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(widget.imageData),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
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
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _toggle() {
    setState(
      () {
        _liked = !_liked;
      },
    );
  }
}
