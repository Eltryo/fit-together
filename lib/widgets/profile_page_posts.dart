import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:fit_together/services/storage.dart';
import 'package:flutter/material.dart';

class ProfilePagePosts extends StatefulWidget {
  const ProfilePagePosts({Key? key}) : super(key: key);

  @override
  State<ProfilePagePosts> createState() => _ProfilePagePostsState();
}

class _ProfilePagePostsState extends State<ProfilePagePosts> {
  Widget? _currentWidget;

  @override
  Widget build(BuildContext context) {
    return _currentWidget ?? const SizedBox.shrink();
  }

  @override
  void initState() {
    super.initState();
    buildGridView();
  }

  void buildGridView() async {
    // final firestoreService = ref.read(firestoreServiceProvider);
    // final authenticationService = ref.read(authenticationServiceProvider);
    // final storageService = ref.read(storageServiceProvider);
    final authenticationService = locator<AuthenticationService>();
    final firestoreService = locator<FirestoreService>();
    final storageService = locator<StorageService>();

    //TODO: use functional approach and consider removing firestore instance
    final imageFiles = await storageService
        .getAllImageFiles(authenticationService.currentUid!);
    final mappedImageFiles = await Future.wait(imageFiles);

    firestoreService.getUserById(authenticationService.currentUid!).then(
      (appUser) {
        setState(
          () {
            _currentWidget = GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: List<Container>.generate(
                appUser.appUserStats.pictureCount,
                (index) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(mappedImageFiles.elementAt(index)!),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      onError: (error) => debugPrint("Error: $error"),
    );
  }
}
