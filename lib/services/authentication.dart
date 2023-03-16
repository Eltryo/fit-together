import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/models/app_user.dart';
import 'package:fit_together/service_locator.dart';
import 'package:fit_together/services/firestore.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  String? get currentUid => _firebaseAuth.currentUser?.uid;

  Future<void> signInToAccount(String email, String password) {
    return _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => null)
        .catchError((error) {
      if (error.code == "user-not-found") {
        debugPrint("No user found for that email");
      } else if (error.code == "wrong-password") {
        debugPrint("Wrong password provided for that user");
      } else if (error.code == "user-disabled") {
        debugPrint("User is disabled");
      }

      throw error;
    }, test: (error) => error is FirebaseAuthException);
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<void> createAccount(String email, String password, String username) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (_) {
        final firestoreService = locator<FirestoreService>();
        firestoreService.addUser(
          AppUser(
            username: username,
            email: email,
          ),
        );
      },
    ).catchError((error) {
      if (error.code == "weak-password") {
        debugPrint("The password provided is too weak");
      } else if (error.code == "email-already-in-use") {
        debugPrint("The account already exists for that email.");
      } else if (error.code == "operation-not-allowed") {
        debugPrint("The account already exists for that email.");
      }

      throw error;
    }, test: (error) => error is FirebaseAuthException);
  }
}
