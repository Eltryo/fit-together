import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  String? get currentUid => _firebaseAuth.currentUser?.uid;

  Future<UserCredential> signInToAccount(String email, String password) {
    try {
      return _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        debugPrint("No user found for that email");
      } else if (e.code == "wrong-password") {
        debugPrint("Wrong password provided for that user");
      } else if (e.code == "user-disabled") {
        debugPrint("User is disabled");
      }
      rethrow;
    }
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<UserCredential> createAccount(
      String email, String password, String username) {
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        debugPrint("The password provided is too weak");
      } else if (e.code == "email-already-in-use") {
        debugPrint("The account already exists for that email.");
      } else if (e.code == "operation-not-allowed") {
        debugPrint("The account already exists for that email.");
      }
      rethrow;
    }
  }
}
