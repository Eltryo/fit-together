import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;

  const AppUser(
      {required this.uid,
      required this.username,
      required this.email,
      this.firstName,
      this.lastName,
      this.imageUrl});

  factory AppUser.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return AppUser(
        uid: data?["uid"],
        username: data?["username"],
        email: data?["email"],
        firstName: data?["firstName"],
        lastName: data?["lastName"],
        imageUrl: data?["imageUrl"]);
  }

  @override
  List<Object?> get props => [username, firstName, lastName, email, imageUrl];

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (imageUrl != null) "imageUrl": imageUrl
    };
  }
}
