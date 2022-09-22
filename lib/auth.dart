
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';
import 'userr.dart';
import 'package:firebase_auth/firebase_auth.dart' ;

class AuthService extends ChangeNotifier  {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create user obj based on firebase user
  Userr? _userFromFirebaseUser(User? user) {
    if (user != null) {
      return Userr(uid: user.uid);
    }
    else {
      return null;
    }
  }

  // auth change user stream
  Stream<Userr?> get user {
    return _auth.authStateChanges()
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }


  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<bool> validatePassword(String password) async {
    var firebaseUser = await _auth.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }
  Future<bool> validateCurrentPassword(String password) async {
    return await validatePassword(password);
  }


  Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }



  // sign in with email and password
  Future Sign(String? em, String? pass) async
  {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: em, password: pass);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future Register(String? em, String? pass, String? equ, String? prenom) async
  {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: em, password: pass);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(equ, prenom);
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      /*showDialog(
          context: navigatorKey.currentContext,
          builder: (context) => Center(
            child: Material(
              color: Colors.transparent,
              child: Text(e.toString()),
            ),
          )
      );*/
    }
  }

  // sign out

  Future signOut() async
  {
    try {
      await _auth.signOut();
      User user = await await _auth.currentUser;
    }
    catch (e) {
      print(e.toString());
    }
  }

}