import 'dart:async';
import 'package:bank_cards/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class LoginService {
  static Future<String> signIn(String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return authResult.user.uid;
  }

  static Future<FirebaseUser> signInWithFacebook(
      FacebookAccessToken myToken) async {
    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: myToken.token);

    // this line do auth in firebase with your facebook credential.
    AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return authResult.user;
  }

  static Future<FirebaseUser> signInWithGoogle(
      GoogleSignInAuthentication googleSignInAuthentication) async {
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // this line do auth in firebase with your facebook credential.
    AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return authResult.user;
  }

  static Future<String> signUp(String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }

  static Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  static Future<void> sendPasswordResetEmail(email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static void addUser(User user) async {
    print("user ${user.firstName} ${user.email} added");
    Firestore.instance.document("users/${user.userID}").setData(user.toJson());
  }

  static Future<bool> checkEmailExist(String email) async {
    QuerySnapshot query =
        await Firestore.instance.collection("users").getDocuments();

    for (DocumentSnapshot document in query.documents) {
      if (document.data.containsKey("email") &&
          document.data.containsValue(email)) {
        return true;
      }
    }

    return false;
  }

  static Future<bool> checkNickNameExist(String nickName) async {
    QuerySnapshot query =
        await Firestore.instance.collection("users").getDocuments();

    for (DocumentSnapshot document in query.documents) {
      if (document.data.containsKey("nickName") &&
          document.data.containsValue(nickName)) {
        return true;
      }
    }

    return false;
  }

  static Future<bool> checkUserExist(String userID) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$userID").get().then((doc) {
        exists = (doc.exists);
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<User> getUser(String userID) {
    return Firestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((doc) {
        return User.fromDocument(doc);
      }).first;
    }).first;
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this e-mail not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'Email address is already taken.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
