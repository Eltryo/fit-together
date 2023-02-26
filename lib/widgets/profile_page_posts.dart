import 'package:fit_together/widgets/image_dialog.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/storage.dart';
import 'package:flutter/material.dart';

class ProfilePagePosts extends StatefulWidget {
  const ProfilePagePosts({Key? key}) : super(key: key);

  @override
  State<ProfilePagePosts> createState() => _ProfilePagePostsState();
}

class _ProfilePagePostsState extends State<ProfilePagePosts> {
  final authenticationService = locator<AuthenticationService>();
  final storageService = locator<StorageService>();

  Widget? _currentWidget;

  @override
  Widget build(BuildContext context) {
    //TODO: use future builder
    return _currentWidget ?? const SizedBox.shrink();
  }

  @override
  void initState() {
    super.initState();
    buildGridView();
  }

  void buildGridView() {
    storageService.getAllImages(authenticationService.currentUid!).then(
      (futureImagesData) {
        Future.wait(futureImagesData).then(
          (imageDataList) {
            setState(
              () {
                _currentWidget = GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: List.generate(
                    imageDataList.length,
                    (index) {
                      final imageData = imageDataList.elementAt(index)!;
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => ImageDialog(imageData: imageData),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(imageData),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          onError: (error) => debugPrint("Error: $error"),
        );
      },
      onError: (error) => debugPrint("Error: $error"),
    );
  }
}
