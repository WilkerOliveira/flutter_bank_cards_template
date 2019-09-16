import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/resources/styles.dart';
import 'package:bank_cards/src/router.dart';

import '../provider_setup.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: "Bank Cards",
        theme: defaultThemeData(),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: Router.initialRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
