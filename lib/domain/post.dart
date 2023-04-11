import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String path;
  final String ownerId;

  const Post({
    required this.path,
    required this.ownerId,
  });

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Post(
      path: data?["path"],
      ownerId: data?["ownerId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "path": path,
        "ownerId": ownerId,
      };
}
