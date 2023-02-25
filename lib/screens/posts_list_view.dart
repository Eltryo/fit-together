import 'dart:typed_data';

import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter/material.dart';

class PostsListView extends StatefulWidget {
  final List<Uint8List?> imagesData;

  const PostsListView({required this.imagesData, Key? key}) : super(key: key);

  @override
  State<PostsListView> createState() => _PostsListViewState();
}

class _PostsListViewState extends State<PostsListView> {
  @override
  Widget build(BuildContext context) {
    final firestoreService = locator<FirestoreService>();
    final authenticationService = locator<AuthenticationService>();
    final appUserFuture =
        firestoreService.getUserById(authenticationService.currentUid!);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text("Posts"),
            FutureBuilder(
              future: appUserFuture,
              builder: (context, snapshot) {
                //TODO: handle errors
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.username,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: widget.imagesData.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(widget.imagesData.elementAt(index)!),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          );
        },
      ),
    );
  }
}
