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
  late FirestoreService _firestoreService;
  late AuthenticationService _authService;

  @override
  void initState() {
    _firestoreService = locator<FirestoreService>();
    _authService = locator<AuthenticationService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text("Comments"),
            FutureBuilder(
              future: _firestoreService.getUserByUid(_authService.currentUid!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.username,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  );
                }
                if (snapshot.hasError) {
                  debugPrint("Error: ${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
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
