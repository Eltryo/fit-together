import 'package:cloud_firestore/cloud_firestore.dart';

class AppUserStats {
  final int pictureCount;
  final int followingCount;
  final int followerCount;

  const AppUserStats({
    this.pictureCount = 0,
    this.followingCount = 0,
    this.followerCount = 0,
  });

  factory AppUserStats.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppUserStats(
      pictureCount: data?["pictureCount"],
      followingCount: data?["followingCount"],
      followerCount: data?["followerCount"],
    );
  }

  factory AppUserStats.fromJson(Map<String, dynamic> json) => AppUserStats(
        pictureCount: json["pictureCount"],
        followingCount: json["followingCount"],
        followerCount: json["followerCount"],
      );

  Map<String, dynamic> toJson() => {
        "pictureCount": pictureCount,
        "followingCount": followingCount,
        "followerCount": followerCount,
      };
}
