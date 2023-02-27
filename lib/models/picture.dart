import 'package:cloud_firestore/cloud_firestore.dart';

class Picture {
  final String path;
  final String ownerId;

  const Picture({
    required this.path,
    required this.ownerId,
  });

  factory Picture.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Picture(
      path: data?["path"],
      ownerId: data?["ownerId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "path": path,
      "ownerId": ownerId,
    };
  }
}
