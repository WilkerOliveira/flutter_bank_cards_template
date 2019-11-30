import 'dart:async';

import 'package:bank_cards/src/exceptions/custom_exception.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/repository/login/login_repository.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  LoginRepository _loginRepository;

  RegisterViewModel() {
    this._loginRepository = LoginRepository();
    super.viewStateController = StreamController();
    super.setStateStream(ViewState.Idle);
  }

  Future<User> registerNewUser(User newUser) async {
    setStateStream(ViewState.Busy);

    try {
      super.error = false;
      super.customErrorMessage = null;

      String uID = await _loginRepository.signUp(
          newUser.email, newUser.password, newUser.nickName);

      newUser.userID = uID;

      await _loginRepository.addUser(newUser);

      return newUser;
    } on CustomException catch (ex) {
      super.error = false;
      super.customErrorMessage = ex.status;
      return null;
    } catch (ex) {
      super.error = true;
      super.customErrorMessage = null;
      return null;
    } finally {
      setStateStream(ViewState.Idle);
    }
  }

  @override
  void dispose() {
    super.viewStateController.close();
    super.dispose();
  }
}
