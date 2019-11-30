import 'dart:async';

import 'package:bank_cards/src/exceptions/exception_messages.dart';
import 'package:bank_cards/src/exceptions/login_exception.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/repository/base_repository.dart';
import 'package:bank_cards/src/repository/login/service/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository extends BaseRepository {
  LoginRepository();

  StreamController<User> _loginController = StreamController<User>.broadcast();

  Stream<User> get currentUser => _loginController.stream;

  Future<FirebaseUser> loginWithFacebook() async {
    //New version, but this new version has an issue
//    final facebookLoginResult =
//        await FacebookLogin().logIn(['email', 'public_profile']);
    //Old version
    final facebookLoginResult = await FacebookLogin()
        .logInWithReadPermissions(['email', 'public_profile']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          return await LoginService.signInWithFacebook(
              facebookLoginResult.accessToken);
        } on PlatformException catch (ex) {
          if (ex.code == "ERROR_INVALID_CREDENTIAL") {
            throw new LoginException.withCode(
                null, ExceptionMessages.userNotRegistered);
          }else if(ex.code == "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL"){
            throw new LoginException.withCode(
                null, ExceptionMessages.userRegisteredWithDiffCredential);
          } else {
            throw new LoginException.withCode(null, ExceptionMessages.error);
          }
        } catch (ex) {
          throw new LoginException.withCode(null, ExceptionMessages.error);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw new LoginException.withCode(
            null, ExceptionMessages.cancelledByUser);
      case FacebookLoginStatus.error:
        throw new LoginException.withCode(null, ExceptionMessages.error);
    }

    return null;
  }

  Future<FirebaseUser> loginWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    try {
      return await LoginService.signInWithGoogle(googleSignInAuthentication);
    } on PlatformException catch (ex) {
      if (ex.code == "ERROR_INVALID_CREDENTIAL") {
        throw new LoginException.withCode(
            null, ExceptionMessages.userNotRegistered);
      }else if(ex.code == "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL"){
        throw new LoginException.withCode(
            null, ExceptionMessages.userRegisteredWithDiffCredential);
      } else {
        throw new LoginException.withCode(null, ExceptionMessages.error);
      }
    } catch (ex) {
      throw new LoginException.withCode(null, ExceptionMessages.error);
    }
  }

  Future<String> signUp(String email, String password, String nickName) async {
    await super.checkInternetConnection();

    if (!await LoginService.checkEmailExist(email)) {
      if (!await LoginService.checkNickNameExist(nickName)) {
        return await LoginService.signUp(email, password);
      } else {
        throw LoginException.withCode(
            null, ExceptionMessages.userNickNameAlreadyExists);
      }
    } else {
      throw LoginException.withCode(
          null, ExceptionMessages.userEmailAlreadyExists);
    }
  }

  Future<FirebaseUser> getCurrentFirebaseUser() async {
    return await LoginService.getCurrentFirebaseUser();
  }

  Future<void> addUser(user) async {

    this._loginController.sink.add(user);

    bool userExist = await LoginService.checkUserExist(user.userID);

    if (!userExist) {
      LoginService.addUser(user);
    } else {
      print("User already exist");
    }

  }

  Future<User> getUser(String uid) async {
    try {
      User current = await LoginService.getUser(uid);

      this._loginController.add(current);

      return current;
    } on Exception catch (ex) {
      print(ex);
      throw new LoginException.withCode(null, ExceptionMessages.error);
    }
  }

  Future<User> signIn(String email, String password) async {
    try {
      String uid = await LoginService.signIn(email, password);

      if (uid != null) {
        return await this.getUser(uid);
      }
    } on PlatformException catch (ex) {
      if (ex.code == "ERROR_WRONG_PASSWORD" ||
          ex.code == "ERROR_USER_NOT_FOUND") {
        throw new LoginException.withCode(
            null, ExceptionMessages.invalidEmailOrPassword);
      } else {
        throw new LoginException.withCode(null, ExceptionMessages.error);
      }
    }

    throw LoginException.withCode(null, ExceptionMessages.userNotRegistered);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await LoginService.sendPasswordResetEmail(email);
    } on PlatformException catch (ex) {
      if (ex.code == "ERROR_USER_NOT_FOUND") {
        throw new LoginException.withCode(
            null, ExceptionMessages.emailNotFound);
      } else {
        throw new LoginException.withCode(null, ExceptionMessages.error);
      }
    }
  }

  Future<void> logout() async {
    await LoginService.signOut();
  }

  void dispose() {
    if (this._loginController != null && !this._loginController.isClosed) {
      this._loginController.close();
    }
  }
}
