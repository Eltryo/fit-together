import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/authentication.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:fit_together/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class ProfileStats extends StatefulWidget {
  const ProfileStats({Key? key}) : super(key: key);

  @override
  State<ProfileStats> createState() => _ProfileStatsState();
}

class _ProfileStatsState extends State<ProfileStats> {
  int? _pictureCount;
  int? _followingCount;
  int? _followerCount;

  // bool _isLoading = true;

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
          // buildText(
          Text(value == null ? "" : value.toString()),
          // ),
          const SizedBox(height: 2),
          Text(text)
        ],
      ),
    );
  }

  //
  // Widget buildText(Text text) {
  //   return ShimmerLoading(
  //     isLoading: _isLoading,
  //     child: _isLoading
  //         ? Container(
  //             width: 15,
  //             height: 15, //TODO change hardcoded height
  //             decoration: BoxDecoration(
  //               color: Colors.black,
  //               borderRadius: BorderRadius.circular(2),
  //             ),
  //           )
  //         : text,
  //   );
  // }

  Widget buildDivider() {
    return const SizedBox(
      height: 24,
      child: VerticalDivider(),
    );
  }

  void fetchAppUserStats() {
    final authService = locator<AuthenticationService>();
    final firestoreService = locator<FirestoreService>();
    if (authService.currentUid != null) {
      firestoreService.getUserById(authService.currentUid!).then((appUser) {
        setState(
          () {
            _pictureCount = appUser.appUserStats.pictureCount;
            _followingCount = appUser.appUserStats.followingCount;
            _followerCount = appUser.appUserStats.followerCount;
            // _isLoading = false;
          },
        );
      }, onError: (error) => debugPrint("Error: $error"));
    }
  }
}
