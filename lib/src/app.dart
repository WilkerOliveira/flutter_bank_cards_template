import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/resources/custom_colors.dart' as tricardColors;
import 'package:bank_cards/src/resources/styles.dart';
import 'package:bank_cards/src/router.dart';

import '../provider_setup.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        //statusBarColor: Color(0xFF202858),
        systemNavigationBarColor: tricardColors.darkBlue,
        statusBarIconBrightness: Brightness.light));

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        //locale: Locale('pt', 'BR'),
        title: "Bank Cards",
        theme: defaultThemeData(),
        initialRoute: Router.initialRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
