import 'package:fit_together/providers.dart';
import 'package:fit_together/widgets/profile_page_posts.dart';
import 'package:fit_together/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/profile_image_widget.dart';
import '../widgets/profile_stats_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String _username = "";
  String _email = "";
  String? _imageUrl;
  late bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ProfileImage(
                imagePath: _checkImagePath(_imageUrl),
                onClicked: () {},
              ),
              const SizedBox(height: 10),
              ShimmerLoading(
                isLoading: _isLoading,
                child: buildText(
                  Text(
                    _username,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ShimmerLoading(
                isLoading: _isLoading,
                child: buildText(
                  Text(
                    _email,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const ProfileStats(),
              const SizedBox(height: 20),
              const ProfilePagePosts()
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.all(kFloatingActionButtonMargin),
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }

  Widget buildText(Text text) {
    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.only(bottom: 1),
        width: MediaQuery.of(context).size.width / 2,
        height: 15, //TODO change hardcoded height
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
      );
    } else {
      return text;
    }
  }

  String _checkImagePath(String? imagePath) {
    if (imagePath == null) {
      return "assets/images/default_user_image.png";
    }
    return imagePath;
  }

  void fetchAppUserData() {
    final authService = ref.read(authServiceProvider);
    final firestoreService = ref.read(firestoreServiceProvider);
    if (authService.currentUid != null) {
      firestoreService.getUserByUid(authService.currentUid!).then((appUser) {
        setState(
          () {
            _username = appUser.username;
            _email = appUser.email;
            _imageUrl = appUser.imageUrl;
            _isLoading = false;
          },
        );
      }, onError: (error) => debugPrint("Error: $error"));
    }
  }
}
