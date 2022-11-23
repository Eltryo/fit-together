import 'package:equatable/equatable.dart';

class ProfileData extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;

  const ProfileData(
      {required this.uid,
      required this.username,
      required this.email,
      this.firstName,
      this.lastName,
      this.imageUrl});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
        uid: json["uid"] ?? "",
        username: json["username"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        imageUrl: json["imageUrl"] ?? "");
  }

  factory ProfileData.empty() {
    return const ProfileData(
        uid: "",
        username: "",
        firstName: "",
        lastName: "",
        email: "",
        imageUrl: "");
  }

  @override
  List<Object?> get props => [username, firstName, lastName, email, imageUrl];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "uid": uid,
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "imageUrl": imageUrl
    };
  }
}
