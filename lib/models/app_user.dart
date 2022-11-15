import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;

  const AppUser(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.imageUrl});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        uid: json["uid"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        imageUrl: json["imageUrl"] ?? "");
  }

  factory AppUser.empty() {
    return const AppUser(
        uid: "", firstName: "", lastName: "", email: "", imageUrl: "");
  }

  @override
  List<Object?> get props => [uid, firstName, lastName, email, imageUrl];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "imageUrl": imageUrl
    };
  }
}
