import 'package:bank_cards/src/exceptions/custom_exception.dart';
import 'package:bank_cards/src/exceptions/exception_messages.dart';

class LoginException extends CustomException {

  LoginException(String cause) {
    this.cause = cause;
  }

  LoginException.withCode(String cause, ExceptionMessages status){
   this.cause = cause;
   this.status = status;
  }

}