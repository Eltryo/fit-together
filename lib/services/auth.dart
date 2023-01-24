import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fit_together/models/app_user.dart';
import 'package:fit_together/services/firestore.dart';

//TODO: Add debug prints for error codes
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  Future<String?> getCurrentUID() async {
    return _firebaseAuth.currentUser?.uid;
  }

  Future signInToAccount(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        debugPrint("No user found for that email");
        rethrow;
      } else if (e.code == "wrong-password") {
        debugPrint("Wrong password provided for that user");
        rethrow;
      }else{
        rethrow;
      }
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint("Sign out failed");
    }
  }

  Future createAccount(String email, String password, String username) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        AppUser appUser = AppUser(
            uid: userCredential.user!.uid, username: username, email: email);
        _firestoreService.addUser(appUser);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        debugPrint("The password provided is too weak");
      } else if (e.code == "email-already-in-use") {
        debugPrint("The account already exists for that email.");
      } else if (e.code == "invalid-email") {
        debugPrint("the email address is not in the required format");
      } else if (e.code == "operation-not-allowed") {
        debugPrint("email/password accounts are not enabled");
      }
    }
  }
}
