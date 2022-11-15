import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on FirebaseUser
  AppUser? _mapFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid, firstName: "", lastName: "", email: "", imageUrl: "") : null; //TODO: build user api
  }

  //Get user stream on auth change
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_mapFirebaseUser);
  }

  Future<AppUser?> signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return _mapFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  //create account with email and password
  Future createAccount(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _mapFirebaseUser(userCredential.user);
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _mapFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        debugPrint("No user found for that email");
      } else if (e.code == "wrong-password") {
        debugPrint("Wrong password provided for that user");
      }
    }
  }
}
