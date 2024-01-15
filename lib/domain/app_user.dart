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
  final Visibility visibility;

  AppUser({
    required this.username,
    required this.email,
    required this.visibility,
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
      visibility: data?["visibility"],
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
        "visibility": visibility.value,
        if (firstName != null) "firstName": firstName,
        if (lastName != null) "lastName": lastName,
        if (imageUrl != null) "imageUrl": imageUrl,
      };
}

class EmailUsernameDto {
  final String username;
  final String? email;

  EmailUsernameDto({required this.username, required this.email});

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
      };
}

enum Visibility {
  public("public"),
  private("private"),
  friends("friends");

  const Visibility(this.value);

  final String value;
}
