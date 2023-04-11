import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String path;
  final String ownerId;
  final Visibility visibility;

  const Post({
    required this.path,
    required this.ownerId,
    this.visibility = Visibility.public,
  });

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Post(
      path: data?["path"],
      ownerId: data?["ownerId"],
      visibility: data?["visibility"],
    );
  }

  Map<String, dynamic> toJson() => {
        "path": path,
        "ownerId": ownerId,
        "visibility": visibility,
      };
}

enum Visibility {
  public("public"),
  private("private"),
  friends("friends");

  const Visibility(this.value);

  final String value;
}
