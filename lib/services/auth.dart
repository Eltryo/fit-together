import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/models/app_user.dart';
import 'package:sports_app/models/profile_data.dart';
import 'package:sports_app/services/firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  //Create user object based on FirebaseUser
  AppUser? _mapToAppUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //Get user stream on auth change
  Stream<AppUser?> get user {
    return _firebaseAuth.authStateChanges().map(_mapToAppUser);
  }

  //sign out
  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  //create account with email and password
  Future createAccount(String email, String password, String username) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        //TODO think of a better identifier for profileDate
        ProfileData profileData = ProfileData(
            uid: userCredential.user!.uid, username: username, email: email);
        _firestoreService.addUser(profileData);
        return _mapToAppUser(userCredential.user);
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
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //sign in with email and password
  Future signInToAccount(String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _mapToAppUser(value.user));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        debugPrint("No user found for that email");
      } else if (e.code == "wrong-password") {
        debugPrint("Wrong password provided for that user");
      }
    }
  }
}
