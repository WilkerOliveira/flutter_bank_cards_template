import 'package:bank_cards/src/exceptions/custom_exception.dart';
import 'package:bank_cards/src/exceptions/exception_messages.dart';
import 'package:bank_cards/src/utils/connectivity.dart';

abstract class BaseRepository {

  Future<void> checkInternetConnection() async {
    if(!await Connectivity.hasInternetConnection()){
      throw CustomException.withCode(null, ExceptionMessages.noInternetConnection);
    }
  }

}