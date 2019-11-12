import 'package:bank_cards/src/exceptions/login_exception.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/repository/login/login_repository.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashViewModel extends BaseViewModel {
  final LoginRepository _loginRepository;

  SplashViewModel(this._loginRepository);

  Future<User> getCurrentUser() async {
    try {
      FirebaseUser fireBaseUser =
      await this._loginRepository.getCurrentFirebaseUser();

      if (fireBaseUser != null) {
        User user = new User(
          firstName: fireBaseUser.displayName,
          userID: fireBaseUser.uid,
          email: fireBaseUser.email ?? '',
          profilePictureURL: fireBaseUser.photoUrl ?? '',
        );

        await this._loginRepository.addUser(user);

        this.error = false;

        return user;
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
