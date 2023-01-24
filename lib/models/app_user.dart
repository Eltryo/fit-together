import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_together/models/app_user_stats.dart';

class AppUser {
  final String uid;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  // final AppUserStats? appUserStats;

  AppUser(
      {required this.uid,
      required this.username,
      required this.email,
      this.firstName,
      this.lastName,
      this.imageUrl,
      // this.appUserStats = const AppUserStats()
      });

  factory AppUser.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return AppUser(
        uid: data?["uid"],
        username: data?["username"],
        email: data?["email"],
        firstName: data?["firstName"],
        lastName: data?["lastName"],
        imageUrl: data?["imageUrl"],
        // appUserStats: data?["appUserStats"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      // "appUserStats": appUserStats,
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (imageUrl != null) "imageUrl": imageUrl
    };
  }
}
