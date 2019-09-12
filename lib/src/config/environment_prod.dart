import 'package:bank_cards/src/config/environment.dart';

class EnvironmentProd extends Environment {
  @override
  String getEndPoint() => "https://SOME_PROD_ENDPOINT";

  @override
  String getClientId() => "SOME_PROD_CLIENT_ID";
}
