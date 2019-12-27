import 'package:flutter/material.dart';
import 'package:bank_cards/locator.dart';
import 'package:bank_cards/src/app.dart';
import 'package:bank_cards/src/config/environment_config.dart';

Future<void> main() {
  EnvironmentConfig.configure(ENVIRONMENT_TYPE.PROD);

  setupLocator();

  runApp(App());
}
