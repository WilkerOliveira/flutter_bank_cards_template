import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bank_cards/locator.dart';
import 'package:bank_cards/src/app.dart';
import 'package:bank_cards/src/config/environment_config.dart';

void main() {
  EnvironmentConfig.configure(ENVIRONMENT_TYPE.PROD);

  setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}
