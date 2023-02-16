import 'package:fit_together/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePagePosts extends ConsumerStatefulWidget {
  const ProfilePagePosts({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePagePosts> createState() => _ProfilePagePostsState();
}

class _ProfilePagePostsState extends ConsumerState<ProfilePagePosts> {
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

  void buildGridView() {
    final firestoreService = ref.read(firestoreServiceProvider);
    final authService = ref.read(authenticationServiceProvider);

    firestoreService.getUserById(authService.currentUid!).then(
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
                //TODO: implement picture count
                (index) => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/prison_mike.jpg"),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
