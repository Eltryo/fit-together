import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_app/models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on FirebaseUser
  AppUser? _userFromFirebaseUser(User? user){
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //Get user stream on auth change
  Stream<AppUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  Future<AppUser?> signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try{
      return await _auth.signOut();
    } on FirebaseAuthException catch (e){
      print(e.toString());
    }
  }
}