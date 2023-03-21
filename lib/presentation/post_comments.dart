import 'package:fit_together/service_locator.dart';
import 'package:fit_together/application/authentication.dart';
import 'package:fit_together/application/firestore.dart';
import 'package:flutter/material.dart';

class PostComments extends StatefulWidget {
  const PostComments({Key? key}) : super(key: key);

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  @override
  Widget build(BuildContext context) {
    final firestoreService = locator<FirestoreService>();
    final authenticationService = locator<AuthenticationService>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text("Comments"),
            FutureBuilder(
              future: firestoreService
                  .getUserByUid(authenticationService.currentUid!),
              builder: (context, snapshot) {
                //TODO: handle error
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.username,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  );
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          //TODO: view comments
        },
      ),
    );
  }
}
