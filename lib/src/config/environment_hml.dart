import 'package:bank_cards/src/config/environment.dart';

class EnvironmentHml extends Environment {
  @override
  String getEndPoint() => "https://SOME_HML_ENDPOINT";

  @override
  String getClientId() => "SOME_HML_CLIENT_ID";
}
