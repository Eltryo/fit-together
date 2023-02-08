import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/models/app_user.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  String? get currentUid => _firebaseAuth.currentUser?.uid;

  Future signInToAccount(String email, String password) {
    return _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .onError(
      (FirebaseAuthException error, _) {
        if (error.code == "user-not-found") {
          debugPrint("No user found for that email");
        } else if (error.code == "wrong-password") {
          debugPrint("Wrong password provided for that user");
        } else if (error.code == "user-disabled") {
          debugPrint("User is disabled");
        }

        return Future.error(error);
      },
    );
  }

  Future signOut() {
    return _firebaseAuth.signOut();
    //apparently does not produce error
  }

  Future createAccount(String email, String password, String username) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .onError(
      (FirebaseAuthException error, _) {
        if (error.code == "weak-password") {
          debugPrint("The password provided is too weak");
        } else if (error.code == "email-already-in-use") {
          debugPrint("The account already exists for that email.");
        }

        return Future.error(error);
      },
    );
  }
}
