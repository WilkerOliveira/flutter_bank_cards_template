import 'package:bank_cards/src/exceptions/login_exception.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/repository/login/login_repository.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel {
  LoginRepository _loginRepository;

  LoginViewModel() {
    this._loginRepository = LoginRepository();
  }

  Future<User> signIn(User user) async {

    setState(ViewState.Busy);

    try {

      this.error = false;
      this.customErrorMessage = null;

      User currentUser =
          await this._loginRepository.signIn(user.email, user.password);

      return currentUser;
    } on LoginException catch (ex) {
      super.error = true;
      super.customErrorMessage = ex.status;
      return null;
    } catch (ex) {
      super.error = true;
      super.customErrorMessage = null;
      return null;
    }
    finally{
      setState(ViewState.Idle);
    }
  }

  Future<User> loginWithFacebook() async {
    try {
      FirebaseUser facebookUser =
          await this._loginRepository.loginWithFacebook();

      if (facebookUser != null) {
        var fireBaseUser = await this._loginRepository.getCurrentFirebaseUser();

        if (fireBaseUser != null) {
          User user = new User(
            firstName: fireBaseUser.displayName,
            userID: facebookUser.uid,
            email: fireBaseUser.email ?? '',
            profilePictureURL: fireBaseUser.photoUrl ?? '',
          );

          await this._loginRepository.addUser(user);

          this.error = false;

          return user;
        }
      }

      return null;
    } on LoginException catch (ex) {
      super.error = true;
      super.customErrorMessage = ex.status;
      return null;
    } catch (ex) {
      super.error = true;
      super.customErrorMessage = null;
      return null;
    }
  }

  Future<User> loginWithGoogle() async {
    try {
      FirebaseUser googleUser = await this._loginRepository.loginWithGoogle();

      if (googleUser != null) {
        var fireBaseUser = await this._loginRepository.getCurrentFirebaseUser();

        if (fireBaseUser != null) {
          User user = new User(
            firstName: fireBaseUser.displayName,
            userID: googleUser.uid,
            email: fireBaseUser.email ?? '',
            profilePictureURL: fireBaseUser.photoUrl ?? '',
          );

          await this._loginRepository.addUser(user);

          this.error = false;

          return user;
        }
      }

      return null;
    } on LoginException catch (ex) {
      super.error = true;
      super.customErrorMessage = ex.status;
      return null;
    } catch (ex) {
      super.error = true;
      super.customErrorMessage = null;
      return null;
    }
  }
}
