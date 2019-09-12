import 'package:bank_cards/src/config/environment.dart';
import 'package:bank_cards/src/config/environment_hml.dart';
import 'package:bank_cards/src/config/environment_prod.dart';

enum ENVIRONMENT_TYPE { HML, PROD, OTHER_HML, OTHER_PROD }

class EnvironmentConfig {
  static final EnvironmentConfig _singleton = new EnvironmentConfig._internal();
  static ENVIRONMENT_TYPE _environmentType;

  static void configure(ENVIRONMENT_TYPE environmentType) async {
    _environmentType = environmentType;
  }

  factory EnvironmentConfig() => _singleton;

  EnvironmentConfig._internal();

  Environment get environment {
    switch (_environmentType) {
      case ENVIRONMENT_TYPE.HML:
        return EnvironmentHml();
      default:
        return EnvironmentProd();
    }
  }
}
