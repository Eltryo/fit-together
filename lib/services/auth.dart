import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/models/app_user.dart';
import 'package:sports_app/models/auth_user.dart';
import 'package:sports_app/page/authenticate.dart';
import 'package:sports_app/services/firestore.dart';

import '../page/home.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Stream<AuthUser?> get user {
  //   var map = _firebaseAuth.authStateChanges().map(_mapToAppUser);
  //   debugPrint("auth state has changed");
  //   return map;
  // }

  void routeToAuthenticationOrHome(){
    final subscription = _firebaseAuth.authStateChanges().listen((user) {
      user == null? debugPrint("user signed out") : debugPrint("user signed in");
    });
  }

  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser!.uid;
  }

  AuthUser? _mapToAppUser(User? user) {
    return user != null ? AuthUser(uid: user.uid) : null;
  }

  Future signInToAccount(String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        return _mapToAppUser(userCredential.user);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        debugPrint("No user found for that email");
      } else if (e.code == "wrong-password") {
        debugPrint("Wrong password provided for that user");
      }
    }
  }

  Future signOut() async {
    try {
      var result = await _firebaseAuth.signOut();
      debugPrint(_firebaseAuth.currentUser.toString());
      return result;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
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
}
