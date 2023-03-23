import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_user_stats.dart';

class AppUser {
  //TODO: create list of liked posts
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final AppUserStats appUserStats;

  AppUser({
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.appUserStats = const AppUserStats(),
  });

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppUser(
      username: data?["username"],
      email: data?["email"],
      firstName: data?["firstName"],
      lastName: data?["lastName"],
      imageUrl: data?["imageUrl"],
      appUserStats: AppUserStats.fromJson(data?["appUserStats"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "appUserStats": appUserStats.toJson(),
        if (firstName != null) "firstName": firstName,
        if (lastName != null) "lastName": lastName,
        if (imageUrl != null) "imageUrl": imageUrl,
      };
}