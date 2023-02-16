import 'package:fit_together/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class ProfileStats extends ConsumerStatefulWidget {
  const ProfileStats({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileStats> createState() => _ProfileStatsState();
}

class _ProfileStatsState extends ConsumerState<ProfileStats> {
  int? _pictureCount;
  int? _followingCount;
  int? _followerCount;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppUserStats();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //TODO: add interactivity
        buildButton("Pictures", _pictureCount),
        buildDivider(),
        buildButton("Following", _followingCount),
        buildDivider(),
        buildButton("Follower", _followerCount),
      ],
    );
  }

  Widget buildButton(String text, int? value) {
    return MaterialButton(
      //TODO: implement button function
      onPressed: () {},
      child: Column(
        children: [
          buildText(
            Text(
              value == null ? "" : value.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 2),
          Text(text)
        ],
      ),
    );
  }

  Widget buildText(Text text) {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: _isLoading
          ? Container(
              width: 15,
              height: 15, //TODO change hardcoded height
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            )
          : text,
    );
  }

  Widget buildDivider() {
    return const SizedBox(
      height: 24,
      child: VerticalDivider(),
    );
  }

  void fetchAppUserStats() {
    final authService = ref.read(authenticationServiceProvider);
    final firestoreService = ref.read(firestoreServiceProvider);
    if (authService.currentUid != null) {
      firestoreService.getUserById(authService.currentUid!).then((appUser) {
        setState(
          () {
            _pictureCount = appUser.appUserStats.pictureCount;
            _followingCount = appUser.appUserStats.followingCount;
            _followerCount = appUser.appUserStats.followerCount;
            _isLoading = false;
          },
        );
      }, onError: (error) => debugPrint("Error: $error"));
    }
  }
}
