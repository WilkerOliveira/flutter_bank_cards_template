import 'package:bank_cards/src/exceptions/custom_exception.dart';
import 'package:bank_cards/src/repository/login/login_repository.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends BaseViewModel {
  LoginRepository loginRepository;

  UserViewModel({@required this.loginRepository});

  Future<void> logout() async {

    setState(ViewState.Busy);

    try {

      super.error = false;
      super.customErrorMessage = null;

      await loginRepository.logout();

    } on CustomException catch (ex) {
      super.error = false;
      super.customErrorMessage = ex.status;
    } catch (ex) {
      super.error = true;
      super.customErrorMessage = null;
    }finally{
      setState(ViewState.Idle);
    }
  }
}
